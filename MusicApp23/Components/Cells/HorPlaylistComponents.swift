//
//  HorPlaylistComponents.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct HorPlaylistComponents: View {
    
    // MARK: - Properties
    let playlistModel: PlaylistModel
    @State private var isShowPlaylistMenu = false

    // MARK: - Body
    var body: some View {
        HStack(spacing: 14) {
            
            // MARK: - Image
            Image(playlistModel.img)
                .resizable()
                .frame(width: 85, height: 85)
                .scaledToFill()
                .cornerRadius(10)
            
            // MARK: - Description
            VStack(alignment: .leading) {
                Text(playlistModel.name)
                    .nameFont()
                    .foregroundStyle(Color.white)
                Text("\(playlistModel.count) Songs")
                    .font(.system(size: 14))
                    .descriptionFont()
            }
            Spacer()
            
            // MARK: - Dots Button
            Button {
                self.isShowPlaylistMenu.toggle()
            } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 15))
                    .foregroundStyle(Color.secondaryFont)
            }
            .buttonStyle(.borderless)
            .popover(isPresented: $isShowPlaylistMenu, attachmentAnchor: .point(.bottom), arrowEdge: .bottom, content: {
                PlaylistMenu()
            })
        }
        .listRowBackground(Color.black)
    }
}

#Preview {
    HorPlaylistComponents(playlistModel: PlaylistModel(img: "playlist4",
                                                       name: "Music for relax",
                                                       count: 25,
                                                       songs: []))
    .preferredColorScheme(.dark)
}
