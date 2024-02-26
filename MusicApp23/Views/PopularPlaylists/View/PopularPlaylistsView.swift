//
//  PopularPlaylistsView.swift
//  MusicApp23
//
//  Created by Dima on 24.12.2023.
//

import SwiftUI


struct PopularPlaylistsView: View {
    
    // MARK: - Properties
    @Environment (\.dismiss) private var dismiss
    
    // MARK: - Body
    var body: some View {
        VStack {
            VStack {
                PopularPlaylistsList()
            }
            .background(Color.bg)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Popular Playlists")
            .customBarButton(name: "back", width: 40, height: 14, placement: .topBarLeading) {
                dismiss()
            }
            .padding(.bottom, 140)
        }
    }
}
