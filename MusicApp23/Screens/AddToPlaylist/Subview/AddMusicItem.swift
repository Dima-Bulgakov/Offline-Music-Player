//
//  AddAllMusicItem.swift
//  MusicApp23
//
//  Created by Dima on 16.01.2024.
//

import SwiftUI

struct AddMusicItem: View {
    
    // MARK: - Properties
    let songModel: SongModel
    @EnvironmentObject var vm: ViewModel
    let toggleCompletion: () -> Void
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 14) {
            
            // MARK: Select Button
            Image(songModel.isSelected ? "select" : "unselect")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 20, height: 20)
                .padding(.horizontal, 6)
            
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
            
            // MARK: Time
            if songModel.duration != nil {
                Text("\(vm.durationFormatted(songModel.duration ?? 0))")
                    .font(.subheadline)
                    .foregroundStyle(Color.gray)
            }
        }
        
        // MARK: - Toggle Cell
        .onTapGesture {
            toggleCompletion()
        }
    }
}

//#Preview {
//    AddAllMusicItem(songModel: SongModel())
//        .environmentObject(ViewModel())
//        .preferredColorScheme(.dark)
//}
