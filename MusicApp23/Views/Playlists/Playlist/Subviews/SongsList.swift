//
//  SongsList.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI
import RealmSwift


struct SongsList: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @ObservedRealmObject var playlist: Playlist
    
    // MARK: - Body
    var body: some View {
        
        // MARK: List Of Songs In Playlist
        List {
            ForEach(sortedPlaylistSongs()) { song in
                SongCellWithDuration(songModel: song)
                    .onTapGesture {
                        vm.playAudio(data: song.data, playlist: Array(sortedPlaylistSongs()))
                        vm.setCurrentSong(song, index: sortedPlaylistSongs().firstIndex(of: song))
                    }
            }
            .onDelete(perform: $playlist.songs.remove)
            .listRowSeparator(.hidden)
        }
        .padding(.bottom, 140)
        .listStyle(InsetListStyle())
    }
    
    // MARK: - Methods
    private func sortedPlaylistSongs() -> [Song] {
        let songsArray = Array(playlist.songs)
        switch vm.currentSortPlaylist {
        case .name:
            return songsArray.sorted(by: { $0.name < $1.name })
        case .artist:
            return songsArray.sorted(by: { ($0.artist ?? "") < ($1.artist ?? "") })
        case .duration:
            return songsArray.sorted(by: { ($0.duration ?? 0) < ($1.duration ?? 0) })
        case .date:
            return songsArray
        case .reverse:
            return vm.isReversePlaylistMusicEnable ? songsArray.reversed() : songsArray
        }
    }
}
