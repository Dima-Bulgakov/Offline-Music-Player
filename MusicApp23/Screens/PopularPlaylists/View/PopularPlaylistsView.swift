//
//  PopularPlaylistsView.swift
//  MusicApp23
//
//  Created by Dima on 24.12.2023.
//

import SwiftUI

struct PopularPlaylistsView: View {
    
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            VStack {
                PopularPlaylistsList()
            }
            .background(Color.bg)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Popular Playlists")
            .customBarButton(name: "back", width: 40, height: 0, placement: .topBarLeading) { dismiss() }
        }
    }
}

#Preview {
    PopularPlaylistsView()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
