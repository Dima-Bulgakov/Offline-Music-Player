//
//  SongsList.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct SongsList: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    var playlistModel: PlaylistModel
    
    // MARK: - Body
    var body: some View {
        
        // MARK: List Of Songs In Playlist
        List {
            ForEach(playlistModel.songs) { song in
                /// Usual Mode
                if vm.editModeInPlaylist {
                    SongCellWithDurationAndEditMode(songModel: song) {
                        vm.isSelectedSongInPlaylists(song: song)
                    }
                /// Edit Mode
                } else {
                    SongCellWithDuration(songModel: song)
                        .onTapGesture {
                            vm.playAudio(data: song.data, playlist: playlistModel.songs)
                            vm.setCurrentSong(song, index: playlistModel.songs.firstIndex(of: song))
                        }
                }
            }
            .onDelete { indices in
                vm.deleteSongsInPlaylist(at: indices, model: playlistModel)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(InsetListStyle())
        
        // MARK: Bottom Buttons
        if vm.editModeInPlaylist {
            HStack {
                ButtonForEditMode(name: "selectAll", width: 100) {
                    vm.selectSongsInPlaylist(model: playlistModel)
                }
                Spacer()
                ButtonForEditMode(name: "addTo", width: 80) {
                    vm.isShowChoosePlaylistView = true
                    vm.selectedSongs = playlistModel.songs.filter { $0.isSelected }
                }
                .sheet(isPresented: $vm.isShowChoosePlaylistView) {
                    ChoosePlaylistView()
                        .onDisappear {
                            vm.resetPlaylistSelection()
                        }
                }
                Spacer()
                ButtonForEditMode(name: "delete", width: 75) {
                    vm.deleteSelectedSongsFromPlaylist(model: playlistModel)
                }
            }
            .padding(.horizontal, 25)
            .padding(.top)
        }
    }

}


#Preview {
    SongsList(playlistModel: PlaylistModel(name: "DDD", image: UIImage(imageLiteralResourceName: "noImagePlaylist"), songs: []))
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
