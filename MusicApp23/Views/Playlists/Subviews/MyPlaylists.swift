//
//  MyPlaylists.swift
//  MusicApp23
//
//  Created by Dima on 05.01.2024.
//

import SwiftUI
import RealmSwift


struct MyPlaylists: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @ObservedResults(Playlist.self, filter: NSPredicate(format: "name != %@", "Favorite")) var playlists
    
    // MARK: - Body
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                
                // MARK: List Of Playlists
                if vm.isEditModePlaylistsShow {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 1))  {
                        ForEach(playlists) { playlist in
                            HorPlaylistCellWithEditMode(playlist: playlist) {
                                vm.selectPlaylist(playlist: playlist)
                            }
                        }
                    }
                } else {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 1)) {
                        ForEach(playlists) { playlist in
                            NavigationLink(destination: PlaylistView(playlist: playlist)) {
                                HorPlaylistCell(playlist: playlist)
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                    .padding(.horizontal)
                }
            }
            
            // MARK: Buttons For Edit Mode
            if vm.isEditModePlaylistsShow {
                HStack {
                    ButtonForEditMode(name: "selectAll", width: 100) {
                        vm.selectAllCells(for: .playlists)
                    }
                    Spacer()
                    ButtonForEditMode(name: "delete", width: 75) {
                        vm.deleteSelectedPlaylists()
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top)
            }
        }
    }
}


// MARK: - Preview
#Preview {
    MyPlaylists()
        .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
        .environmentObject(RealmManager(name: "viewModel"))
        .environmentObject(ImportManager())
        .preferredColorScheme(.dark)
}
