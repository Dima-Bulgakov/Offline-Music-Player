//
//  ListChoosePlaylist.swift
//  MusicApp23
//
//  Created by Dima on 07.01.2024.
//

import SwiftUI

struct ListChoosePlaylist: View {
    // MARK: - Properties
    let playlistModel: PlaylistModel
    let toggleCompletion: () -> Void

    // MARK: - Body
    var body: some View {
        HStack(spacing: 14) {
            
            // MARK: Select Circle
            Image(playlistModel.isSelected ? "select" : "unselect")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 20, height: 20)
                .padding(.horizontal, 6)
            
            // MARK: Image
            Image(uiImage: playlistModel.image)
                .resizable()
                .frame(width: 85, height: 85)
                .scaledToFill()
                .cornerRadius(10)
            
            // MARK: Description
            VStack(alignment: .leading) {
                Text(playlistModel.name)
                    .nameFont()
                    .foregroundStyle(Color.white)
                Text("\(playlistModel.count) Songs")
                    .font(.system(size: 14))
                    .descriptionFont()
            }
            Spacer()
        }
        .onTapGesture {
            toggleCompletion()
        }
    }
}

//#Preview {
//    ListChoosePlaylist(playlistModel: PlaylistModel(img: "playlist4",
//                                                    name: "Music for relax",
//                                                    count: 25,
//                                                    songs: []))
//    .preferredColorScheme(.dark)
//}
