//
//  HorPlaylistCellWithSelection.swift
//  MusicApp23
//
//  Created by Dima on 24.01.2024.
//

import SwiftUI
import RealmSwift


struct HorPlaylistCellWithEditMode: View {
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @ObservedRealmObject var playlist: Playlist
    
    let toggleCompletion: () -> Void
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 14) {
            
            // MARK: Toggle
            Image(systemName: vm.selectedPlaylists.contains(playlist.id) ? "circle.inset.filled" : "circle")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(.leading)
                .foregroundColor(Color.accent)
            
            // MARK: Image
            if let coverImageData = playlist.image, let uiImage = UIImage(data: coverImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 85, height: 85)
                    .cornerRadius(10)
            } else {
                ZStack {
                    Image("noImagePlaylist")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 85, height: 85)
                        .cornerRadius(10)
                }
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
        .onTapGesture {
            toggleCompletion()
        }
    }
}
