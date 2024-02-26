//
//  PopularPlaylists.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//


import SwiftUI
import RealmSwift

struct PopularPlaylistsPreview: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @ObservedResults(Playlist.self, filter: NSPredicate(format: "name != %@", "Favorite")) var playlists
    
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
                
                /// "View All" Button
                NavigationLink(destination: PopularPlaylistsView()) {
                    Text("View All")
                        .blueButtonFont()
                }
            }
            .padding(.horizontal)
            
            // MARK: - Playlists
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(playlists.sorted { $0.numberOfListens > $1.numberOfListens } ) { playlist in
                        NavigationLink(destination: PlaylistView(playlist: playlist)) {
                            VerPlaylistCell(playlist: playlist)
                        }
                    }
                }
                .offset(x: 16)
            }
            .frame(height: 191)
        }
    }
}


// MARK: - Preview
#Preview {
    PopularPlaylistsPreview()
        .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
        .environmentObject(RealmManager(name: "viewModel"))
        .environmentObject(ImportManager())
        .preferredColorScheme(.dark)
}
