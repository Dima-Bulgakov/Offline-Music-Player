//
//  AddToPlaylistView.swift
//  MusicApp23
//
//  Created by Dima on 06.01.2024.
//

import SwiftUI

// MARK: - Enum Buttons
enum AllMusicAndFavoritesTab: String, CaseIterable, Identifiable {
    case allMusic = "All Music"
    case favorites = "Favorites"
    
    var id: String { rawValue }
}

var addToPlaylistTab: [AllMusicAndFavoritesTab] = AllMusicAndFavoritesTab.allCases


// MARK: - Main View
struct AddToPlaylistView: View {
    
    // MARK: Properties
    @EnvironmentObject var vm: ViewModel
    @Environment (\.dismiss) private var dismiss
    @StateObject var gestureManager: GestureManager = .init()
    
    @State var offset: CGFloat = 0
    @State var currentTab: AllMusicAndFavoritesTab = addToPlaylistTab.first!
    @State var isTapped: Bool = false
    
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
                        ForEach(addToPlaylistTab) { tab in
                            if tab == addToPlaylistTab[0] {
                                AddAllMusic()
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
                                AddFavorites()
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
            
            // MARK: - Botton Buttons
            HStack {
                Button {
                    vm.selectAllSongs()
                } label: {
                    Image("selectAll")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                }
                Spacer()
                Button {
                    vm.isShowChoosePlaylistView = true
                    vm.selectedSongs = vm.allSongs.filter { $0.isSelected }
                } label: {
                    Image("addTo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                }
                .sheet(isPresented: $vm.isShowChoosePlaylistView) {
                    ChoosePlaylistView()
                        .onDisappear {
                            vm.resetPlaylistSelection()
                        }
                }
            }
            .padding(.horizontal)
            .padding(.top)
        }
        
        // MARK: - NavigationBar
        .navigationBarBackButtonHidden(true)
        .customNavigationTitle(title: "Add To Playlist")
        .customBarButton(name: "cancel", width: 32, height: 16, placement: .topBarLeading) {
            dismiss()
        }
    }
    
    // MARK: - Methods
    @ViewBuilder
    func DynamicTabHeader(size: CGSize) -> some View {
        VStack(alignment: .leading, spacing: 22) {
            
            HStack(spacing: 0) {
                ForEach(AllMusicAndFavoritesTab.allCases, id: \.self) { tab in
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
                                ForEach(AllMusicAndFavoritesTab.allCases) { tab in
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
    func indexOf(tab: AllMusicAndFavoritesTab) -> Int {
        let index = addToPlaylistTab.firstIndex { CTab in
            CTab == tab
        } ?? 0
        
        return index
    }
}


#Preview {
    NavigationView {
        AddToPlaylistView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
    }
}
