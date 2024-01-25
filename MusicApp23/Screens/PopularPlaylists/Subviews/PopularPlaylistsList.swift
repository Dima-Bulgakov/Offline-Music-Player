//
//  PopularPlaylistsList.swift
//  MusicApp23
//
//  Created by Dima on 24.12.2023.
//

import SwiftUI

struct PopularPlaylistsList: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        List {
            ForEach(vm.popularPlaylists) { playlist in
                NavigationLink(destination: PlaylistView(playlist: playlist)) {
                    HorPlaylistCell(playlistModel: playlist)
                        .onAppear {
                            vm.playlistListens(playlist: playlist)
                        }
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    PopularPlaylistsList()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
