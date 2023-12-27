//
//  PlaylistView.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct Playlist: View {
    
    // MARK: - Properties
    var playlist: PlaylistModel
    @Environment (\.dismiss) private var dismiss
    
    // MARK: - Body
    var body: some View {
        VStack {
            
            // MARK: - Subviews
            Head(playlist: playlist)
            SongsList()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.bg)
        .navigationBarBackButtonHidden(true)
        .navigationTitle(playlist.name)
        .customBarButton(name: "back", width: 40, height: 0, placement: .topBarLeading) { dismiss() }
    }
}

#Preview {
    Playlist(playlist: PlaylistModel(img: "playlist1", name: "Workout", count: 23, songs: []))
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
