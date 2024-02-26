//
//  MyNusicView.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI

struct MyMusicView: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
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
        
        // MARK: - NavigationBar
        .customNavigationTitle(title: "My Music")
        .customBarButton(name: vm.isEditModeAllMusicShow ? "done" : "edit", width: 32, height: 16, placement: .topBarTrailing) {
            if !vm.allSongs.isEmpty {
                vm.isEditModeAllMusicShow.toggle()
                vm.isPlayerPresented.toggle()
                if !vm.isEditModeAllMusicShow {
                    vm.unselectSongs()
                }
            }
            vm.isMenuVisible = false
            vm.searchAllMusic = ""
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if !vm.isEditModeAllMusicShow {
                    ButtonForEditMode(name: "twoArrow", width: 20) {
                        vm.reverseOrder()
                        vm.searchAllMusic = ""
                        vm.isMenuVisible = false
                    }
                }
            }
        }
        .gesture(DragGesture().onEnded { value in
            if value.translation.width > 100 {
                presentationMode.wrappedValue.dismiss()
            }
        })
    }
}


#Preview {
    NavigationView {
        MyMusicView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
    }
}
