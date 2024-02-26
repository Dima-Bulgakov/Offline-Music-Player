//
//  MainMenuView.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI


struct MainMenuView: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                MenuItem(image: "home", title: "Home", isSelected: vm.selectedView == 1)
                    .onTapGesture {
                        vm.selectedView = 1
                        vm.isMenuVisible.toggle()
                    }
                Divider()
                MenuItem(image: "myMusic", title: "My Music", isSelected: vm.selectedView == 2)
                    .onTapGesture {
                        vm.selectedView = 2
                        vm.isMenuVisible.toggle()
                    }
                Divider()
                MenuItem(image: "playlists", title: "Playlists", isSelected: vm.selectedView == 3)
                    .onTapGesture {
                        vm.selectedView = 3
                        vm.isMenuVisible.toggle()
                    }
                Divider()
                MenuItem(image: "settings", title: "Settings", isSelected: vm.selectedView == 4)
                    .onTapGesture {
                        vm.selectedView = 4
                        vm.isMenuVisible.toggle()
                    }
            }
            .padding()
            .background(Color.white)
            .frame(width: 175, height: 168)
            .clipShape(
                RoundedCorners(cornerRadius: 15, corners: [.topLeft, .topRight, .bottomRight])
            )
        }
    }
}
