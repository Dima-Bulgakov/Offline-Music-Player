//
//  MyPlaylists.swift
//  MusicApp23
//
//  Created by Dima on 05.01.2024.
//

import SwiftUI

struct MyPlaylists: View {
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                
                if vm.editModePlaylists {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 1))  {
                        ForEach(vm.allPlaylists) { playlist in
                            HorPlaylistCellWithEditMode(playlistModel: playlist) {
                                vm.isSelectedPlaylist(playlist: playlist)
                            }
                        }
                    }
                } else {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 1)) {
                        
                        ForEach(vm.allPlaylists) { playlist in
                            NavigationLink(destination: PlaylistView(playlist: playlist)) {
                                HorPlaylistCell(playlistModel: playlist)
                                    .onAppear {
                                        vm.playlistListens(playlist: playlist)
                                    }
                            }
                        }
                        
                    }
                    .listRowSeparator(.hidden)
                    .padding(.horizontal)
                    
                }
            }
            .padding(.bottom, vm.editModeFavorite ? 0 : 130)
            
            // MARK: Bottom Buttons
            if vm.editModePlaylists {
                HStack {
                    ButtonForEditMode(name: "selectAll", width: 100) {
                        vm.selectAllSongs()
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


#Preview {
    MyPlaylists()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
