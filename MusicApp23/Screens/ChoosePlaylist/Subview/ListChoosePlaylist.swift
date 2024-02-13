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
                .scaledToFill()
                .frame(width: 85, height: 85)
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

#Preview {
    ListChoosePlaylist(playlistModel: PlaylistModel(name: "Workout", image: UIImage(imageLiteralResourceName: "testPlaylistImage"), songs: []), toggleCompletion: {})
    .preferredColorScheme(.dark)
}
