//
//  SongMeu.swift
//  MusicApp23
//
//  Created by Dima on 24.12.2023.
//

import SwiftUI


struct SongMenu: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            
            /// Add To Favorite Button
            CustomeMenuButton(image: "favoriteSM", text: "Add to Favorite") {
                vm.addCurrentSongToFavorites()
            }
            Divider()
            
            /// Add To Playlist Button
            CustomeMenuButton(image: "playlistSM", text: "Add to Playlist") {
                vm.addCurrentSongToPlaylists()
            }
            
            /// ChoosePlaylistView Sheet
            .sheet(isPresented: $vm.isShowChoosePlaylistView) {
                ChoosePlaylistView()
                    .onDisappear {
                        
                    }
            }
            Divider()
            
            /// Delete Button
            CustomeMenuButton(image: "deleteSM", text: "Delete") {
                vm.deleteCurrentSong()
            }
        }
        .frame(width: 175, height: 143)
        .background(Color.menu)
        .modifier(ConditionalCompactAdaptation())
    }
}


struct ConditionalCompactAdaptation: ViewModifier {
    
    // MARK: Propety
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    // MARK: Method
    func body(content: Content) -> some View {
        if #available(iOS 16.4, *) {
            return content.presentationCompactAdaptation(.none)
        } else {
            return content
        }
    }
}
