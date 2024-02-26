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
                    if vm.isEditModeFavoriteShow {
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
                .listRowBackground(Color.bg)
            }
            .listStyle(PlainListStyle())

            // MARK: Bottom Buttons
            if vm.isEditModeFavoriteShow {
                HStack {
                    
                    /// Select All Button
                    ButtonForEditMode(name: "selectAll", width: 100) {
                        vm.selectAllSongs()
                    }
                    Spacer()
                    
                    /// Add To Button
                    ButtonForEditMode(name: "addTo", width: 80) {
                        vm.isShowChoosePlaylistView = true
                        vm.selectedSongs = vm.favoriteSongs.filter { $0.isSelected }
                    }
                    
                    /// Sheet Choose Playlists For "Add To" Button
                    .sheet(isPresented: $vm.isShowChoosePlaylistView) {
                        ChoosePlaylistView()
                            .onDisappear {
                                vm.resetPlaylistSelection()
                            }
                    }
                    Spacer()
                    
                    /// Delete Button
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
