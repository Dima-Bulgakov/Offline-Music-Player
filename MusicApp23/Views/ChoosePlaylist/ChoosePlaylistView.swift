//
//  ChoosePlaylistView.swift
//  MusicApp23
//
//  Created by Dima on 07.01.2024.
//

import SwiftUI

struct ChoosePlaylistView: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var rm: RealmManager
    @Environment (\.dismiss) private var dismiss
    
    // MARK: - Body
    var body: some View {
        VStack {
            
            // MARK: Header
            HeaderChoosePlaylist()
            
            // MARK: Playlists
            List {
                ForEach(rm.playlistsArray) { playlist in
                    HorPlaylistCellWithEditMode(playlist: playlist) {
                        vm.selectPlaylist(playlist: playlist)
                    }
                    .listRowSeparator(.hidden)
                }
                .listRowBackground(Color.bunner)
            }
            .listStyle(PlainListStyle())
            
            // MARK: Add To Buttons
            Button {
                vm.addSelectedSongToPlaylist()
                dismiss()
            } label: {
                Image("addTo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 82)
                    .foregroundColor(Color.accent)
            }
        }
        .background(Color.bunner)
    }
}


#Preview {
    ChoosePlaylistView()
        .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
        .environmentObject(RealmManager(name: "viewModel"))
        .environmentObject(ImportManager())
        .preferredColorScheme(.dark)
}

