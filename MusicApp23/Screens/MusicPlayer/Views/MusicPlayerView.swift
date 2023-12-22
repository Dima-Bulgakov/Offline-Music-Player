//
//  ContentView.swift
//  MusicApp23
//
//  Created by Dima on 19.12.2023.
//

import SwiftUI
import AVFoundation
import RealmSwift

struct MusicPlayerView: View {
    
    // MARK: - Properties
    @ObservedObject var vm: ViewModel
    @State var selectedRow = Set<UUID>()
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                // MARK: - List
                List(selection: $selectedRow) {
                    ForEach(vm.songs) { song in
                        HStack {
                            if let coverImageData = song.coverImageData, let uiImage = UIImage(data: coverImageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .background(Color.teal)
                                    .foregroundColor(.white)
                            } else {
                                ZStack {
                                    Color.gray
                                        .frame(width: 50, height: 50)
                                    Image(systemName: "music.note")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 30)
                                        .foregroundColor(.white)
                                }
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(song.name)
                                Text(song.artist ?? song.name)
                                    .font(.callout)
                            }
                            Spacer()
                            if let duration = song.duration {
                                Text("\(vm.durationFormatted(duration))")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .onTapGesture {
                            vm.playAudio(data: song.data)
                        }
                    }
                    .onDelete(perform: vm.deleteSong)
                }

                
                // MARK: - Picker
                Button("Выбрать файл") {
                    vm.actionSheetVisible = true
                }
                .confirmationDialog("Выберите тип", isPresented: $vm.actionSheetVisible) {
                    Button("MP3 файл") {
                        vm.selectedDocument = nil
                        vm.selectedDocumentName = nil
                        vm.isFilePickerPresented.toggle()
                    }
                }

                // MARK: - Buttons
                HStack {
                    Button {
                        vm.playPause()
                    } label: {
                        Image(systemName: vm.isPlaying ? "pause.fill" : "play.fill")
                    }
                }
                .font(.largeTitle)
                .padding(.vertical)
            }
            .sheet(isPresented: self.$vm.isFilePickerPresented) {
                ImportFileManager(songs: $vm.songs, file: $vm.selectedDocument, fileName: $vm.selectedDocumentName, vm: vm)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                    
                }
            }
        }
    }
}


#Preview {
    MusicPlayerView(vm: ViewModel())
}
