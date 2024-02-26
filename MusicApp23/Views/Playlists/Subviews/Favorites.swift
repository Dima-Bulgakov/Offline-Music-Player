//
//  Favorites.swift
//  MusicApp23
//
//  Created by Dima on 05.01.2024.
//

import SwiftUI
import RealmSwift


struct Favorites: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var rm: RealmManager
    @ObservedResults(Playlist.self, filter: NSPredicate(format: "name == 'Favorite'")) var playlists
    
    // MARK: - Body
    var body: some View {
        VStack {
            
            // MARK: List Of Favorite Playlist
            List {
                if let favoritePlaylist = playlists.first {
                    ForEach(favoritePlaylist.songs) { song in
                        if vm.isEditModeFavoriteShow {
                            SongCellWithDurationAndEditMode(songModel: song) {
                                vm.selectSong(songId: song.id)
                            }
                        } else {
                            SongCellWithDuration(songModel: song)
                                .onTapGesture {
                                    vm.playAudio(data: song.data, playlist: Array(favoritePlaylist.songs))
                                    vm.setCurrentSong(song, index: favoritePlaylist.songs.firstIndex(of: song))
                                }
                        }
                    }
                    .onDelete(perform: deleteSongs)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.bg)
                }
            }
            .listStyle(PlainListStyle())
            
            // MARK: Buttons For Edit Mode
            if vm.isEditModeFavoriteShow {
                HStack {
                    ButtonForEditMode(name: "selectAll", width: 100) {
                        vm.selectAllCells(for: .favorites)
                    }
                    Spacer()
                    
                    ButtonForEditMode(name: "addTo", width: 80) {
                        vm.isShowChoosePlaylistView = true
                    }
                    .sheet(isPresented: $vm.isShowChoosePlaylistView) {
                        ChoosePlaylistView()
                    }
                    Spacer()
                    
                    ButtonForEditMode(name: "delete", width: 75) {
                        vm.deleteSelectedFavorites()
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top)
            }
        }
    }
    
    // MARK: - Methods
    func deleteSongs(at offsets: IndexSet) {
        guard let favoritePlaylist = playlists.first else { return }
        offsets.forEach { index in
            let songId = favoritePlaylist.songs[index].id
            rm.removeSongFromFavorite(songId: songId)
        }
    }
}


// MARK: - Preview
#Preview {
    Favorites()
        .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
        .environmentObject(RealmManager(name: "viewModel"))
        .environmentObject(ImportManager())
        .preferredColorScheme(.dark)
}
