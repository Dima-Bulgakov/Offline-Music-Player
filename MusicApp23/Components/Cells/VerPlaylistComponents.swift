//
//  VerPlaylistComponents.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct VerPlaylistComponents: View {
    
    // MARK: - Properties
    let playlistModel: PlaylistModel
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ZStack {
                // MARK: - Background Image
                Image(playlistModel.img)
                    .resizable()
                    .frame(width: 140, height: 100)
                    .scaledToFill()
                    .blur(radius: 3.0, opaque: true)
                    .cornerRadius(10)
                // MARK: - Main Image
                Image(playlistModel.img)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            .padding(.bottom, 3)
            // MARK: - Album Name
            Text(playlistModel.name)
                .nameFont()
                .foregroundStyle(Color.primaryFont)
            // MARK: - Songs Count
            Text("\(playlistModel.count) Songs")
                .descriptionFont()
                .foregroundStyle(Color.secondaryFont)
        }
        .listRowBackground(Color.bg)
    }
}


#Preview {
    VerPlaylistComponents(playlistModel: PlaylistModel(img: "playlist1", name: "Car Travel", count: 32, songs: []))
        .preferredColorScheme(.dark)
}
