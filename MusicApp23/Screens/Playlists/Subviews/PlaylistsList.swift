//
//  PlaylistsList.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct PlaylistsList: View {
    
    // MARK: - Properties
    var playlists: [PlaylistModel]
    

    // MARK: - Body
    var body: some View {
        ScrollView(.vertical) {
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 1)) {
                ForEach(playlists) { playlist in
                    NavigationLink(destination: Playlist(playlist: playlist)) {
                        HorPlaylistComponents(playlistModel: playlist)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .padding(.horizontal)
        }
        .mask {
            Rectangle()
                .padding(.bottom, -100)
        }
    }
}

#Preview {
    PlaylistsList(playlists: ViewModel().myPlaylists)
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
