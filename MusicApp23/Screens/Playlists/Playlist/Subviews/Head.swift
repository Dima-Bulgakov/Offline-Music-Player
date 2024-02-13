//
//  Head.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct Head: View {
    
    // MARK: - Properties
    var playlistModel: PlaylistModel
    @EnvironmentObject var vm: ViewModel
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    @State private var isEditing: Bool = false
    @State private var editedName: String = ""
    
    // MARK: - Body
    var body: some View {
        HStack {
            
            // MARK: Cover Of Playlist
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    if let im = selectedImage {
                        Image(uiImage: im)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .cornerRadius(20)
                    } else {
                        Image(uiImage: playlistModel.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .cornerRadius(20)

                    }
                }
                
                Image(systemName: "camera.fill")
                    .font(.title)
                    .opacity(0.5)
                    .padding(12)
                    .onTapGesture { /// Show Image Picker
                        isImagePickerPresented.toggle()
                    }
                    
                    // MARK: Image Picker To Edit Cover Of Playlist
                    .sheet(isPresented: $isImagePickerPresented) {
                        ImagePicker(selectedImage: $selectedImage, onImageSelected: { newImage in
                            if let index = vm.allPlaylists.firstIndex(where: { $0.id == playlistModel.id }) {
                                vm.allPlaylists[index].image = newImage
                            }
                        })
                    }
            }
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    
                    // MARK: Button For Edit
                    Button {
                        isEditing = true
                        editedName = playlistModel.name
                    } label: {
                        Image(systemName: "pencil.line")
                            .font(.title3)
                    }
                    .offset(x: 5, y: -5)
                    
                    // MARK: Alert For Edit Playlist's Name
                    .alert("Edit Your Name", isPresented: $isEditing) {
                        TextField(editedName, text: $editedName)
                            .foregroundColor(.fontScheme)
                        Button("Cancel", role: .cancel, action: {})
                        Button("Save",action: {
                            if let index = vm.allPlaylists.firstIndex(where: { $0.id == playlistModel.id }) {
                                vm.allPlaylists[index].name = editedName
                            }
                            isEditing = false
                        })
                    } message: {
                        Text("Please Enter your name to edit.")
                    }
                    
                    // MARK: Name Of Playlist
                    Text(playlistModel.name)
                        .titleFont()
                }
                
                // MARK: Count Of Songs
                Text("\(playlistModel.count) Songs")
                    .descriptionFont()
                
                // MARK: Shuffle Button
                SortButton()
                    .padding(.top)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    Head(playlistModel: PlaylistModel(name: "For Car", image: UIImage(imageLiteralResourceName: "noImagePlaylist"), songs: []))
        .preferredColorScheme(.dark)
        .environmentObject(ViewModel())
}


