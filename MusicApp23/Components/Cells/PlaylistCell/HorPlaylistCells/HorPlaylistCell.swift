//
//  HorPlaylistCell.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI
import RealmSwift

struct HorPlaylistCell: View {
    
    // MARK: - Properties
    @EnvironmentObject var rm: RealmManager
    @ObservedRealmObject var playlist: Playlist
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 14) {
            
            // MARK: Image
            if let coverImageData = playlist.image, let uiImage = UIImage(data: coverImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 85, height: 85)
                    .cornerRadius(10)
            } else {
                Image("noImagePlaylist")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 85, height: 85)
                    .cornerRadius(10)
            }
            
            // MARK: Description
            VStack(alignment: .leading) {
                Text(playlist.name)
                    .nameFont()
                    .foregroundStyle(Color.white)
                Text("\(playlist.count) Songs")
                    .font(.system(size: 14))
                    .descriptionFont()
            }
            Spacer()
        }
    }
}
