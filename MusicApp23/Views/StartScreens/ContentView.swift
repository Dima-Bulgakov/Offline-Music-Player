//
//  ContentView.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI
import RealmSwift


struct ContentView: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var rm: RealmManager
    @EnvironmentObject var importManager: ImportManager
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // MARK: - Main Menu With All Views
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
        
        // MARK: - Import Sheets
        /// Files
        .sheet(isPresented: self.$importManager.isFilesPresented) {
            ImportFileManager(file: $importManager.selectedDocument, fileName: $importManager.selectedDocumentName, vm: vm, rm: rm)
        }
        /// Safari
        .sheet(isPresented: self.$importManager.isShowSafariAlert, content: {
            SafariSheetView()
        })
        /// Share
        .sheet(isPresented: self.$importManager.isShowShareAlert, content: {
            ShareSheetView()
        })
        /// Camera
        .sheet(isPresented: $importManager.isPhotoPickerPresented) {
            ImportCameraManager(audioPlayer: $vm.audioPlayer, vm: vm)
        }
        /// Wi-Fi Transfer
        .sheet(isPresented: $importManager.isShowWiFiTransferSheet) {
            WiFiTransferView()
        }
    }
}


// MARK: - Preview
#Preview {
    ContentView()
        .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
        .environmentObject(RealmManager(name: "viewModel"))
        .environmentObject(ImportManager())
        .preferredColorScheme(.dark)
}
