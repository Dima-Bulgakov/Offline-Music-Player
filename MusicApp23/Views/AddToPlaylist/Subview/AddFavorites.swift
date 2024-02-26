//
//  AddFavorites.swift
//  MusicApp23
//
//  Created by Dima on 06.01.2024.
//

import SwiftUI
import RealmSwift


struct AddFavorites: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @ObservedResults(Playlist.self, filter: NSPredicate(format: "name == 'Favorite'")) var playlists
    
    // MARK: - Body
    var body: some View {
        List {
            if let favoritePlaylist = playlists.first  {
                ForEach(favoritePlaylist.songs) { song in
                    SongCellWithDurationAndEditMode(songModel: song) {
                        vm.selectSong(songId: song.id)
                    }
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(PlainListStyle())
    }
}
