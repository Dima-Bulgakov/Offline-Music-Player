//
//  VerPlaylistCell.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI
import RealmSwift


struct VerPlaylistCell: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var rm: RealmManager
    
    @ObservedRealmObject var playlist: Playlist
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ZStack {
                
                // MARK: Background Image
                if let coverImageData = playlist.image, let uiImage = UIImage(data: coverImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 100)
                        .blur(radius: 3.0, opaque: true)
                        .cornerRadius(10)
                } else {
                    Image("noImagePlaylist")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 100)
                        .blur(radius: 3.0, opaque: true)
                        .cornerRadius(10)
                }
                
                // MARK: Main Image
                if let coverImageData = playlist.image, let uiImage = UIImage(data: coverImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(10)
                } else {
                    Image("noImagePlaylist")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(10)
                }
            }
            .padding(.bottom, 3)
            
            // MARK: Album Name
            Text(playlist.name)
                .nameFont()
                .foregroundStyle(Color.primaryFont)
            
            // MARK: Songs Count
            Text("\(playlist.count) Songs")
                .descriptionFont()
                .foregroundStyle(Color.secondaryFont)
        }
        .listRowBackground(Color.bg)
    }
}
