//
//  MainMenu.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI


struct MainMenu: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                
                switch vm.selectedView {
                case 1:
                    MusicPlayerView()
                        .blur(radius: vm.isMenuVisible ? 1.5 : 0)
                case 2:
                    MyMusicView()
                        .blur(radius: vm.isMenuVisible ? 1.5 : 0)
                case 3:
                    PlaylistsView()
                        .blur(radius: vm.isMenuVisible ? 1.5 : 0)
                case 4:
                    SettingsView()
                        .blur(radius: vm.isMenuVisible ? 1.5 : 0)
                default:
                    EmptyView()
                }
            }
            .background(Color.bg)
            
            // MARK: Menu Button
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        vm.isMenuVisible.toggle()
                        vm.isEditModeAllMusicShow = false
                        vm.isEditModeFavoriteShow = false
                        vm.isEditModePlaylistsShow = false
                        vm.isEditModeInPlaylistShow = false
                        vm.isPlayerPresented = true
                        vm.searchAllMusic = ""
                        vm.searchRecently = ""
                    } label: {
                        Image("menu")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                            .foregroundColor(Color.accent)
                    }
                }
            }
            .overlay {
                Group {
                    if vm.isMenuVisible {
                        GeometryReader { _ in
                            withAnimation {
                                MainMenuView()
                                    .offset(x: 20)
                            }
                        }
                        .background(
                            Color.black
                                .opacity(0.35)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    withAnimation {
                                        vm.isMenuVisible.toggle()
                                    }
                                }
                        )
                    }
                }
            }
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
