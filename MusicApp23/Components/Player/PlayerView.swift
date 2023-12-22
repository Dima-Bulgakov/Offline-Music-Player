//
//  PlayerView.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI

struct PlayerView: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        HStack {
            
            // MARK: PlayPause Button
            Button {
                vm.playPause()
            } label: {
                Image(systemName: vm.isPlaying ? "pause.fill" : "play.fill")
            }
        }
        .font(.largeTitle)
        .padding(.vertical)
    }
}
