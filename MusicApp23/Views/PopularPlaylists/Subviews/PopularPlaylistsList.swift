//
//  PopularPlaylistsList.swift
//  MusicApp23
//
//  Created by Dima on 24.12.2023.
//

import SwiftUI
import RealmSwift


struct PopularPlaylistsList: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var rm: RealmManager
    @ObservedResults(Playlist.self, filter: NSPredicate(format: "name != %@", "Favorite")) var playlists
    
    // MARK: - Body
    var body: some View {
        List {
            ForEach(playlists) { playlist in
                NavigationLink(destination: PlaylistView(playlist: playlist)) {
                    HorPlaylistCell(playlist: playlist)
                }
            }
            .listRowBackground(Color.bg)
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
    }
}
