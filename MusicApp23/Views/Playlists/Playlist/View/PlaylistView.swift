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
    @Environment(\.presentationMode) var presentationMode
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
        .customBarButton(name: vm.isEditModeInPlaylistShow ? "done" : "edit", width: 32, height: 16, placement: .topBarTrailing) {
            vm.isEditModeInPlaylistShow.toggle()
            vm.isPlayerPresented.toggle()
        }
        .customBarButton(name: "add", width: 25, height: 17, placement: .topBarTrailing) {
            alertAddPlaylist(myPlaylists: $vm.allPlaylists) {
                vm.isEditModePlaylistsShow = false
                vm.isEditModeFavoriteShow = false
                vm.isEditModeInPlaylistShow = false
                vm.isPlayerPresented = true
                
                vm.isShowAddToPlaylistView = true
            }
        }
        .customBarButton(name: "back", width: 40, height: 14, placement: .topBarLeading) {
            dismiss()
            vm.isEditModeInPlaylistShow = false
            vm.isPlayerPresented = true
        }
        .gesture(DragGesture().onEnded { value in
            if value.translation.width > 100 {
                presentationMode.wrappedValue.dismiss()
            }
        })
    }
}

#Preview {
    NavigationView {
        PlaylistView(playlist: PlaylistModel(name: "Workout", image: UIImage(imageLiteralResourceName: "playlist5"), songs: []))
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
    }
}
