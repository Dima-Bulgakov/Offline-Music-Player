//
//  PlaylistsView.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI

// MARK: - Enum Buttons
enum PlaylistsAndFavoritesTab: String, CaseIterable, Identifiable {
    case myPlaylists = "My Playlists"
    case favorites = "Favorites"
    
    var id: String { rawValue }
}

/// All Cases Enums Buttons
var sampleTabs: [PlaylistsAndFavoritesTab] = PlaylistsAndFavoritesTab.allCases


// MARK: - Main View
struct PlaylistsView: View {
    
    // MARK: Properties
    @State var offset: CGFloat = 0
    @State var currentTab: PlaylistsAndFavoritesTab = sampleTabs.first!
    @State var isTapped: Bool = false
    @EnvironmentObject var vm: ViewModel
    @StateObject var gestureManager: GestureManager = .init()
    
    // MARK: Body
    var body: some View {
        VStack {
            GeometryReader { proxy in
                let screenSize = proxy.size
                
                VStack {
                    
                    // MARK: My Playlists And Favorite Buttons
                    DynamicTabHeader(size: screenSize)
                    
                    // MARK: TabView
                    TabView(selection: $currentTab) {
                        ForEach(sampleTabs) { tab in
                            if tab == sampleTabs[0] {
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
        
        
        // MARK: - NavigationBar
        .customNavigationTitle(title: "Playlists")
        .customBarButton(name: vm.isEditModeFavoriteShow || vm.isEditModePlaylistsShow ? "done" : "edit", width: 32, height: 16, placement: .topBarTrailing) {
            
            switch currentTab {
            case .myPlaylists:
                if !vm.allPlaylists.isEmpty {
                    vm.isEditModePlaylistsShow.toggle()
                    vm.isPlayerPresented.toggle()
                }
                vm.isEditModeFavoriteShow = false
            case .favorites:
                if !vm.favoriteSongs.isEmpty {
                    vm.isEditModeFavoriteShow.toggle()
                    vm.isPlayerPresented.toggle()
                }
                vm.isEditModePlaylistsShow = false
                if !vm.isEditModeFavoriteShow {
                    vm.unselectSongs()
                }
            }
            vm.isMenuVisible = false
        }
        
        /// Button To Create New Playlist
        .customBarButton(name: "add", width: 25, height: 17, placement: .topBarTrailing) {
            alertAddPlaylist(myPlaylists: $vm.allPlaylists) {
                vm.isEditModePlaylistsShow = false
                vm.isEditModeFavoriteShow = false
                vm.isPlayerPresented = true
                vm.isShowAddToPlaylistView = true
                vm.isMenuVisible = false
            }
        }
        
        NavigationLink(destination: AddToPlaylistView().onDisappear {
            vm.unselectSongs()
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
                                        .foregroundColor(.blue)
                                        .containerShape(Capsule())
                                        .onTapGesture {
                                            // MARK: Disabling The TabScrollOffset Detection
                                            isTapped = true
                                            // MARK: Updating Tab
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
                    .frame(width: (size.width - 30) / CGFloat(sampleTabs.count))
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
        return (-offset / size.width) * ((size.width - padding) / CGFloat(sampleTabs.count))
    }
    
    // MARK: Tab Index
    func indexOf(tab: PlaylistsAndFavoritesTab) -> Int {
        let index = sampleTabs.firstIndex { CTab in
            CTab == tab
        } ?? 0
        
        return index
    }
}


#Preview {
    NavigationView {
        PlaylistsView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
    }
}
