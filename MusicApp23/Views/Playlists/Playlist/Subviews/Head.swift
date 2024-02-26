//
//  Head.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI
import RealmSwift


struct Head: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var rm: RealmManager
    
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    @State private var isEditing: Bool = false
    @State private var editedName: String = ""
    
    @ObservedRealmObject var playlist: Playlist
        
    // MARK: - Body
    var body: some View {
        HStack {
            
            // MARK: Cover Of Playlist
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    if let coverImageData = playlist.image, let uiImage = UIImage(data: coverImageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .cornerRadius(20)
                    } else {
                        Image("noImagePlaylist")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .cornerRadius(10)
                    }
                }
                .frame(width: 150, height: 150)
                
                // MARK: Button For Change Cover Of Playlist
                Image(systemName: "camera.fill")
                    .font(.title)
                    .opacity(0.5)
                    .padding(12)
                    .onTapGesture { /// Show Image Picker
                        isImagePickerPresented.toggle()
                    }
                
                // MARK: Image Picker To Change Cover Of Playlist
                    .sheet(isPresented: $isImagePickerPresented) {
                        ImagePickerForChangeImage(selectedImage: $selectedImage, onImageSelected: { newImage in
                            if let newImageData = newImage.jpegData(compressionQuality: 1.0) {
                                // Обновляем изображение плейлиста в Realm
                                self.rm.updatePlaylistImage(playlistId: self.playlist.id, newImageData: newImageData)
                            }
                        })
                    }
            }
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    
                    // MARK: Button For Edit Name Of Playlist
                    Button {
                        isEditing = true
                        editedName = playlist.name
                    } label: {
                        Image(systemName: "pencil.line")
                            .foregroundColor(Color.accent)
                            .font(.title3)
                    }
                    .offset(x: 5, y: -5)
                    
                    // MARK: - Alert For Edit Name Of Playlist
                    .onChange(of: isEditing) { newValue in
                        if newValue {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                let alert = UIAlertController(title: "Edit Playlist Name", message: "Enter a new name for your playlist.", preferredStyle: .alert)
                                alert.addTextField { textField in
                                    textField.text = self.playlist.name
                                }
                                let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                                    guard let newName = alert.textFields?.first?.text, !newName.isEmpty else { return }
                                    
                                    self.rm.updatePlaylistName(playlistId: self.playlist.id, newName: newName)
                                    self.isEditing = false
                                }
                                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                                    self.isEditing = false
                                }
                                alert.addAction(cancelAction)
                                alert.addAction(saveAction)
                                
                                if let viewController = UIApplication.shared.windows.first?.rootViewController {
                                    viewController.present(alert, animated: true, completion: nil)
                                }
                            }
                        }
                    }
                    
                    // MARK: Name Of Playlist
                    Text(playlist.name)
                        .titleFont()
                }
                
                // MARK: Count Of Songs
                Text("\(playlist.count) Songs")
                    .descriptionFont()
                
                // MARK: Shuffle Button
                SortButtonPlaylist(playlist: playlist)
                    .padding(.top)
            }
            .padding()
        }
        .padding()
    }
}


// MARK: - Preview
#Preview {
    Head(playlist: Playlist(name: ""))
        .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
        .environmentObject(RealmManager(name: "viewModel"))
        .environmentObject(ImportManager())
        .preferredColorScheme(.dark)
}
