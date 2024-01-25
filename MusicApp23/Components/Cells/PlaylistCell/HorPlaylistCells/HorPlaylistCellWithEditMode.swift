//
//  HorPlaylistCellWithSelection.swift
//  MusicApp23
//
//  Created by Dima on 24.01.2024.
//

import SwiftUI

struct HorPlaylistCellWithEditMode: View {
    // MARK: - Properties
    let playlistModel: PlaylistModel

    // MARK: - Body
    var body: some View {
        HStack(spacing: 14) {
            
            // MARK: - Image
            Image(uiImage: playlistModel.image)
                .resizable()
                .scaledToFill()
                .frame(width: 85, height: 85)
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
        }
    }
}

//#Preview {
//    HorPlaylistCellWithSelection()
//}
