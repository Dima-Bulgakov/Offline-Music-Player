//
//  ArtistCellForRecently.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI

struct ArtistCellForRecently: View {
    
    // MARK: - Properties
    let songModel: SongModel
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 14) {
            
            // MARK: Image
            if let coverImageData = songModel.coverImageData, let uiImage = UIImage(data: coverImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .background(Color.teal)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            } else {
                ZStack {
                    Color.gray
                        .frame(width: 50, height: 50)
                    Image(systemName: "music.note")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                        .foregroundColor(Color.primaryFont)
                }
                .frame(width: 50, height: 50)
                .cornerRadius(10)
            }
            
            // MARK: Description
            VStack(alignment: .leading) {
                Text(songModel.name)
                    .artistFont()
                    .lineLimit(1)
                    .foregroundStyle(Color.primaryFont)
                Text(songModel.artist ?? songModel.name)
                    .songFont()
                    .lineLimit(1)
                    .foregroundStyle(Color.secondaryFont)
            }
            Spacer()
        }

        // MARK: - Turn On the Music by Tapping And Get Current Song
        .onTapGesture {
            vm.playAudio(data: songModel.data)
            vm.setCurrentSong(songModel, index: vm.songs.firstIndex(of: songModel))
        }
    }
}

#Preview {
    ArtistCellForRecently(songModel: SongModel())
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}

