//
//  MusicList.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct MusicList: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        VStack {
            
            // MARK: List Of All Songs
            List {
                ForEach(vm.filteredSongs) { song in
                    if vm.isEditModeAllMusicShow {
                        SongCellWithDurationAndEditMode(songModel: song) {
                            vm.isSelectedSongInArrays(model: song, playlist: &vm.allSongs)
                        }
                        .listRowBackground(Color.bg)
                    } else {
                        SongCellWithDuration(songModel: song)
                            .onTapGesture {
                                vm.playAudio(data: song.data, playlist: vm.allSongs)
                                vm.setCurrentSong(song, index: vm.allSongs.firstIndex(of: song))
                            }
                            .listRowBackground(Color.bg)
                    }
                    
                }
                .onDelete(perform: vm.deleteSong)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .padding(.bottom, vm.isEditModeAllMusicShow ? 0 : 140)
            .ignoresSafeArea(.keyboard)
            
            
            // MARK: Bottom Buttons For Edit Mode
            if vm.isEditModeAllMusicShow  {
                HStack {
                    ButtonForEditMode(name: "selectAll", width: 100) {
                        vm.selectAllSongs()
                    }
                    Spacer()
                    ButtonForEditMode(name: "addTo", width: 80) {
                        vm.isShowChoosePlaylistView = true
                        vm.selectedSongs = vm.allSongs.filter { $0.isSelected }
                    }
                    .sheet(isPresented: $vm.isShowChoosePlaylistView) {
                        ChoosePlaylistView()
                            .onDisappear {
                                vm.resetPlaylistSelection()
                            }
                    }
                    Spacer()
                    ButtonForEditMode(name: "delete", width: 75) {
                        
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top)
            }
        }
    }
}


#Preview {
    MusicList()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
