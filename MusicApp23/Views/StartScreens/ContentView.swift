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
    @EnvironmentObject var importManager: VMImportManager
    
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
                            .onTapGesture {
                                vm.isMenuVisible = false
                            }
                    }
                }
            }
        }
        .ignoresSafeArea(.keyboard) 
        
        // MARK: - Import Sheets And Alerts
        /// Sheet For Import Files
        .sheet(isPresented: self.$importManager.isFilesPresented) {
            ImportFileManager(songs: $vm.allSongs, file: $importManager.selectedDocument, fileName: $importManager.selectedDocumentName, vm: vm)
        }
        /// Sheet For Import Camera's Files
        .sheet(isPresented: $importManager.isPhotoPickerPresented) {
                    ImportCameraManager(audioPlayer: $vm.audioPlayer, vm: vm)
                }
        .sheet(isPresented: $importManager.isShowWiFiTransferSheet) {
            WiFiTransferView()
        }
        .overlay(
            Group {
                /// Alert For Share Import
                if importManager.isShowShareAlert {
                    AlertForPossibilities(title: .share, image: "shareAlert") {
                        importManager.isShowShareAlert.toggle()
                    }
                    .transition(.scale)
                    /// Alert For Safari Import
                } else if importManager.isShowSafariAlert {
                    AlertForPossibilities(title: .safari, image: "DeathStar") {
                        importManager.isShowSafariAlert.toggle()
                    }
                    .transition(.scale)
                }
            }
        )
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
        .environmentObject(VMImportManager())
        .preferredColorScheme(.dark)
}
