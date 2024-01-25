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
    @Environment (\.dismiss) private var dismiss
    
    // MARK: - Body
    var body: some View {
        VStack {
            // MARK: Header
            HeaderChoosePlaylist()
            
            // MARK: Playlists
            List {
                ForEach(vm.allPlaylists) { pl in
                    ListChoosePlaylist(playlistModel: pl) {
                        vm.isSelectedPlaylist(playlist: pl)
                    }
                        .listRowSeparator(.hidden)
                }
                .listRowBackground(Color.bunner)
            }
            .listStyle(PlainListStyle())
            Button {
                vm.addSelectedSongsToPlaylists()
                dismiss()
            } label: {
                Image("addTo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 82)
            }
            
        }
        .background(Color.bunner)
    }
}

#Preview {
    NavigationView {
        ChoosePlaylistView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
    }
}


