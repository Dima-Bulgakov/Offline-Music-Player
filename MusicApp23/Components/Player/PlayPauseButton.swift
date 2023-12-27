//
//  PlayPauseButton.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct PlayPauseButton: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @State private var isButtonDisabled: Bool = true
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white, lineWidth: 2)
                .frame(width: 63, height: 63)
                .offset(y: -4)
            if let coverImageData = vm.currentSong?.coverImageData,
               let uiImage = UIImage(data: coverImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .offset(y: -4)
                    .opacity(0.8)
            }
            CustomPlayerButton(image: vm.isPlaying ? "pause" : "play", size: 25, color: Color.primaryFont) {
                vm.playPause()
            }
            .disabled(isButtonDisabled)
        }
        // Выключить кнопку если песня не выбрана
        .onReceive(vm.$currentSong) { currentSong in
            isButtonDisabled = currentSong == nil
        }
    }
}

#Preview {
    PlayPauseButton()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
