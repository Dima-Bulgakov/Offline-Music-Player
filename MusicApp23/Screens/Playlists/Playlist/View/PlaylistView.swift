//
//  PlaylistView.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct PlaylistView: View {
    
    // MARK: - Properties
    var playlist: PlaylistModel
    @Environment (\.dismiss) private var dismiss
    @EnvironmentObject var vm: ViewModel
    
    
    // MARK: - Body
    var body: some View {
        VStack {
            
            // MARK: - Subviews
            Head(playlistModel: playlist)
            SongsList(playlistModel: playlist)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.bg)
        .navigationBarBackButtonHidden(true)
        
        // MARK: - NavigationBar
        .customNavigationTitle(title: playlist.name)
        .customBarButton(name: vm.editModeInPlaylist ? "done" : "edit", width: 32, height: 16, placement: .topBarTrailing) {
            vm.editModeInPlaylist.toggle()
            vm.isPlayerPresented.toggle()
        }
        .customBarButton(name: "add", width: 25, height: 17, placement: .topBarTrailing) {
            alertView(myPlaylists: $vm.allPlaylists) {
//                vm.isShowChoosePlaylistView = true
            }
        }
        .customBarButton(name: "back", width: 40, height: 0, placement: .topBarLeading) { dismiss() }
    }
}

//#Preview {
//    NavigationView {
//        PlaylistView(playlist: PlaylistModel(img: "playlist1", name: "Workout", count: 23, songs: []))
//            .environmentObject(ViewModel())
//            .preferredColorScheme(.dark)
//    }
//}
