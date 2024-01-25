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
    
    // MARK: - Body
    var body: some View {
        VStack {
            VStack {
                
                // MARK: - Subviews
                if !vm.editModeAllMusic {
                    AllMusicSearchBar()
                    HStack(spacing: 16) {
                        ShuffleButton()
                        SortButton()
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
        .customBarButton(name: vm.editModeAllMusic ? "done" : "edit", width: 32, height: 16, placement: .topBarTrailing) {
            vm.editModeAllMusic.toggle()
            vm.isPlayerPresented.toggle()
            if !vm.editModeAllMusic {
                vm.unselectSongs()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if !vm.editModeAllMusic {
                    ButtonForEditMode(name: "twoArrow", width: 20) {
                        vm.reverseOrder()
                    }
                }
            }
        }
    }
}


#Preview {
    NavigationView {
        MyMusicView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
    }
}
