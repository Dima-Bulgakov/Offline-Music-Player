//
//  MyNusicView.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI
import RealmSwift


struct MyMusicView: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var rm: RealmManager
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Body
    var body: some View {
        VStack {
            VStack {
                
                // MARK: - Subviews
                if !vm.isEditModeAllMusicShow {
                    
                    AllMusicSearchBar()
                    
                    HStack(spacing: 16) {
                        ShuffleButton()
                        SortButtonAllMusic()
                    }
                    .padding(.top, 14)
                    .padding(.horizontal)
                }
                
                MusicList()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.bg)
        }
        
        // MARK: - Navigation Bar
        .customNavigationTitle(title: "My Music")
        
        /// Edit Button
        .customBarButton(name: vm.isEditModeAllMusicShow ? "done" : "edit", width: 32, height: 16, placement: .topBarTrailing) {
            vm.searchAllMusic = ""
            if let songs = rm.songs, !songs.isEmpty {
                vm.isEditModeAllMusicShow.toggle()
                vm.isPlayerPresented.toggle()
                vm.unselectAllSongs()
            }
            vm.isMenuVisible = false
        }
        
        /// Reverse Button
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if !vm.isEditModeAllMusicShow {
                    ButtonForEditMode(name: "reverse", width: 20) {
                        vm.currentSortAllSongs = .reverse
                        vm.isReverseAllMusicEnable.toggle()
                        vm.searchAllMusic = ""
                        vm.isMenuVisible = false
                    }
                }
            }
        }
        
        // MARK: - DragGesture
        .gesture(DragGesture().onEnded { value in
            if value.translation.width > 100 {
                presentationMode.wrappedValue.dismiss()
            }
        })
    }
}


// MARK: - Preview
#Preview {
    NavigationView {
        MyMusicView()
            .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
            .environmentObject(RealmManager(name: "viewModel"))
            .environmentObject(ImportManager())
            .preferredColorScheme(.dark)
    }
}
