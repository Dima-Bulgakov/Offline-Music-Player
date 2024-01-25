//
//  Favorites.swift
//  MusicApp23
//
//  Created by Dima on 05.01.2024.
//

import SwiftUI

struct Favorites: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        VStack {
            List {
                ForEach(vm.favoriteSongs) { song in
                    if vm.editModeFavorite {
                        SongCellWithDurationAndEditMode(songModel: song) {
                            vm.isSelectedSongInArrays(model: song, playlist: &vm.favoriteSongs)
                        }
                    } else {
                        SongCellWithDuration(songModel: song)
                            .onTapGesture {
                                vm.playAudio(data: song.data, playlist: vm.favoriteSongs)
                                vm.setCurrentSong(song, index: vm.favoriteSongs.firstIndex(of: song))
                            }
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
            .padding(.bottom, vm.editModeFavorite ? 0 : 130)
            
            // MARK: Bottom Buttons
            if vm.editModeFavorite {
                HStack {
                    ButtonForEditMode(name: "selectAll", width: 100) {
                        vm.selectAllSongs()
                    }
                    Spacer()
                    ButtonForEditMode(name: "addTo", width: 80) {
                        vm.isShowChoosePlaylistView = true
                        vm.selectedSongs = vm.favoriteSongs.filter { $0.isSelected }
                    }
                    .sheet(isPresented: $vm.isShowChoosePlaylistView) {
                        ChoosePlaylistView()
                            .onDisappear {
                                vm.resetPlaylistSelection()
                            }
                    }
                    Spacer()
                    ButtonForEditMode(name: "delete", width: 75) {
                        vm.deleteSelectedSongsFromFavorites()
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top)
            }
        }
    }
}

#Preview {
    NavigationView {
        PlaylistsView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
    }
}
