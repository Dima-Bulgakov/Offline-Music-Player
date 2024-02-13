//
//  PopularPlaylists.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct PopularPlaylists: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    private let numberColumns = [
        GridItem(.flexible()),
    ]
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                
                // MARK: - Title
                Text("Popular Playlists")
                    .titleFont()
                Spacer()
                
                // MARK: - View All Button
                NavigationLink(destination: PopularPlaylistsView()) {
                    Text("View All")
                        .blueButtonFont()
                }
            }
            .padding(.horizontal)
            
            // MARK: - Playlists
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(vm.popularPlaylists) { playlist in
                        NavigationLink(destination: PlaylistView(playlist: playlist)) {
                            VerPlaylistCell(playlistModel: playlist)
                        }
                    }
                }
                .offset(x: 16)
            }
            .frame(height: 191)
        }
    }
}

#Preview {
    PopularPlaylists()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
