//
//  ContentView.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // MARK: - All Views
            MainMenu()
                .zIndex(1)
            
            // MARK: - Player
            if !vm.isEditModeFavoriteShow || !vm.isEditModeAllMusicShow || !vm.isEditModePlaylistsShow || !vm.isEditModeInPlaylistShow {
                if vm.isPlayerPresented {
                    if !vm.isShowAddToPlaylistView {
                        PlayerView()
                            .offset(y: 30)
                            .zIndex(2)
                    }
                }
            }
        }
        .ignoresSafeArea(.keyboard) 
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
        .environmentObject(VMImportManager())
        .preferredColorScheme(.dark)
}
