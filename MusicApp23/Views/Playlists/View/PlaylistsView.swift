//
//  PlaylistsView.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI
import RealmSwift


// MARK: - Enum Playlists Buttons
enum PlaylistsAndFavoritesTab: String, CaseIterable, Identifiable {
    case myPlaylists = "My Playlists"
    case favorites = "Favorites"
    
    var id: String { rawValue }
}

/// All Cases Enums Buttons
var allCasesPlaylistTabs: [PlaylistsAndFavoritesTab] = PlaylistsAndFavoritesTab.allCases


struct PlaylistsView: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var rm: RealmManager
    
    @State var offset: CGFloat = 0
    @State var currentTab: PlaylistsAndFavoritesTab = allCasesPlaylistTabs.first!
    @State var isTapped: Bool = false
    
    @StateObject var gestureManager: GestureManager = .init()
    
    // MARK: - Body
    var body: some View {
        VStack {
            GeometryReader { proxy in
                let screenSize = proxy.size
                VStack {
                    
                    // MARK: "My Playlists" And "Favorite" Buttons
                    DynamicTabHeader(size: screenSize)
                    
                    // MARK: TabView
                    TabView(selection: $currentTab) {
                        ForEach(allCasesPlaylistTabs) { tab in
                            if tab == allCasesPlaylistTabs[0] {
                                MyPlaylists()
                                    .offsetX { value in
                                        if currentTab == tab && !isTapped {
                                            offset = value - (screenSize.width * CGFloat(indexOf(tab: tab)))
                                        }
                                        if value == 0 && isTapped {
                                            isTapped = false
                                        }
                                        if isTapped && gestureManager.isInteracting {
                                            isTapped = false
                                        }
                                    }
                                    .tag(tab)
                            } else {
                                Favorites()
                                    .offsetX { value in
                                        if currentTab == tab && !isTapped {
                                            offset = value - (screenSize.width * CGFloat(indexOf(tab: tab)))
                                        }
                                        if value == 0 && isTapped {
                                            isTapped = false
                                        }
                                        if isTapped && gestureManager.isInteracting {
                                            isTapped = false
                                        }
                                    }
                                    .tag(tab)
                            }
                        }
                    }
                    .ignoresSafeArea()
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .onAppear(perform: gestureManager.addGesture)
                    .onDisappear(perform: gestureManager.removeGesture)
                    
                }
                .frame(width: screenSize.width, height: screenSize.height)
            }
            .background(Color.bg)
            .padding(.bottom, vm.isEditModeFavoriteShow || vm.isEditModePlaylistsShow ? 0 : 140)
            .ignoresSafeArea(.keyboard)
        }
        .onChange(of: currentTab) { newTab in
            switch newTab {
            case .myPlaylists:
                vm.isEditModeFavoriteShow = false
                vm.unselectAllSongs()
                vm.unselectAllPlaylists()
            case .favorites:
                vm.isEditModePlaylistsShow = false
                vm.unselectAllSongs()
                vm.unselectAllPlaylists()
            }
        }
        
        // MARK: - Navigation Bar
        .customNavigationTitle(title: "Playlists")
        .customBarButton(name: vm.isEditModeFavoriteShow || vm.isEditModePlaylistsShow ? "done" : "edit", width: 32, height: 16, placement: .topBarTrailing) {
            switch currentTab {
            case .myPlaylists:
                vm.isEditModePlaylistsShow.toggle()
                vm.isPlayerPresented.toggle()
            case .favorites:
                vm.isEditModeFavoriteShow.toggle()
                vm.isPlayerPresented.toggle()
            }
            vm.isMenuVisible = false
        }
        
        /// Button To Create New Playlist
        .customBarButton(name: "add", width: 25, height: 17, placement: .topBarTrailing) {
            vm.isEditModePlaylistsShow = false
            vm.isEditModeFavoriteShow = false
            vm.isPlayerPresented = true
            vm.isMenuVisible = false
            vm.unselectAllSongs()
            vm.unselectAllPlaylists()
            alertAddPlaylist(realmManager: self.rm) {
                vm.isShowAddToPlaylistView = true
            }
        }
        
        /// AddToPlaylistView Sheet
        NavigationLink(destination: AddToPlaylistView().onDisappear {
            vm.isShowAddToPlaylistView = false
        },isActive: $vm.isShowAddToPlaylistView) {
            EmptyView()
        }
        .hidden()
    }
    
    // MARK: - Methods
    @ViewBuilder
    func DynamicTabHeader(size: CGSize) -> some View {
        VStack(alignment: .leading, spacing: 22) {
            
            HStack(spacing: 0) {
                ForEach(PlaylistsAndFavoritesTab.allCases, id: \.self) { tab in
                    Text(tab.rawValue)
                        .fontWeight(.semibold)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                }
            }
            .overlay(alignment: .leading) {
                Capsule()
                    .fill(.white)
                    .overlay(alignment: .leading, content: {
                        GeometryReader { _ in
                            HStack(spacing: 0) {
                                ForEach(PlaylistsAndFavoritesTab.allCases) { tab in
                                    Text(tab.rawValue)
                                        .fontWeight(.semibold)
                                        .padding(.vertical, 10)
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(Color.accent)
                                        .containerShape(Capsule())
                                        .onTapGesture {
                                            /// Disabling The TabScrollOffset Detection
                                            isTapped = true
                                            /// Updating Tab
                                            withAnimation(.easeInOut) {
                                                currentTab = tab
                                                offset = -(size.width) * CGFloat(indexOf(tab: tab))
                                            }
                                        }
                                }
                            }
                            .offset(x: -tabOffser(size: size, padding: 30))
                        }
                        .frame(width: size.width - 30)
                    })
                    .frame(width: (size.width - 30) / CGFloat(allCasesPlaylistTabs.count))
                    .mask({
                        Capsule()
                    })
                    .offset(x: tabOffser(size: size, padding: 30))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            Rectangle()
                .fill(.black)
                .ignoresSafeArea()
        )
    }
    
    // MARK: Tab Offset
    func tabOffser(size: CGSize, padding: CGFloat) -> CGFloat {
        return (-offset / size.width) * ((size.width - padding) / CGFloat(allCasesPlaylistTabs.count))
    }
    
    // MARK: Tab Index
    func indexOf(tab: PlaylistsAndFavoritesTab) -> Int {
        let index = allCasesPlaylistTabs.firstIndex { CTab in
            CTab == tab
        } ?? 0
        return index
    }
}


// MARK: - Preview
#Preview {
    PlaylistsView()
        .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
        .environmentObject(RealmManager(name: "viewModel"))
        .environmentObject(ImportManager())
        .preferredColorScheme(.dark)
}
