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
                MenuItem(image: "home", title: "Home")
                    .onTapGesture {
                        selectedView = 1
                        isMenuVisible.toggle()
                    }
                Divider()
                MenuItem(image: "myMusic", title: "My Music")
                    .onTapGesture {
                        selectedView = 2
                        isMenuVisible.toggle()
                    }
                Divider()
                MenuItem(image: "playlists", title: "Playlists")
                    .onTapGesture {
                        selectedView = 3
                        isMenuVisible.toggle()
                    }
                Divider()
                MenuItem(image: "settings", title: "Settings")
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
}
