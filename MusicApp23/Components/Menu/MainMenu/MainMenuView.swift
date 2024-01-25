//
//  MainMenuView.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI

struct MainMenuView: View {
    
    // MARK: Properties
    @Binding var selectedView: Int
    @Binding var isMenuVisible: Bool
    
    // MARK: Body
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                MenuItem(image: "home", title: "Home", isSelected: selectedView == 1)
                    .onTapGesture {
                        selectedView = 1
                        isMenuVisible.toggle()
                    }
                Divider()
                MenuItem(image: "myMusic", title: "My Music", isSelected: selectedView == 2)
                    .onTapGesture {
                        selectedView = 2
                        isMenuVisible.toggle()
                    }
                Divider()
                MenuItem(image: "playlists", title: "Playlists", isSelected: selectedView == 3)
                    .onTapGesture {
                        selectedView = 3
                        isMenuVisible.toggle()
                    }
                Divider()
                MenuItem(image: "settings", title: "Settings", isSelected: selectedView == 4)
                    .onTapGesture {
                        selectedView = 4
                        isMenuVisible.toggle()
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

#Preview {
    MainMenuView(selectedView: .constant(1), isMenuVisible: .constant(true))
        .preferredColorScheme(.dark)
}
