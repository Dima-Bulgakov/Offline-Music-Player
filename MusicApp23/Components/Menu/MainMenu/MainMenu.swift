//
//  MainMenu.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI

struct MainMenu: View {
    
    // MARK: - Properties
    @State private var selectedView: Int = 1
    @State private var isMenuVisible: Bool = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                switch selectedView {
                case 1:
                    MusicPlayerView()
                case 2:
                    MyMusicView()
                case 3:
                    PlaylistsView()
                case 4:
                    SettingsView()
                default:
                    EmptyView()
                }
            }
            
            // MARK: - Menu Button
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isMenuVisible.toggle()
                    } label: {
                        Image("menu")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22)
                    }
                }
            }
            .background(Color.bg)
        }
        
        // MARK: - List of Screens in Menu
        .overlay {
            Group {
                if isMenuVisible {
                    GeometryReader(content: { _ in
                        withAnimation {
                            MainMenuView(selectedView: $selectedView, isMenuVisible: $isMenuVisible)
                                .offset(x: 20, y: 45)
                        }
                    }).background(
                        Color.black
                            .opacity(0.3)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation {
                                    isMenuVisible.toggle()
                                }
                            }
                    )
                }
            }
        }
    }
}

#Preview {
    MainMenu()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
