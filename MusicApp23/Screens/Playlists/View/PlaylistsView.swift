//
//  PlaylistsView.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI

struct PlaylistsView: View {
    
    // MARK: - Properties
    @State var offset: CGFloat = 0
    @State var currentTab: Tab = sampleTabs.first!
    @State var isTapped: Bool = false
    @EnvironmentObject var vm: ViewModel
    @StateObject var gestureManager: GestureManager = .init()
    
    // MARK: - Body
    var body: some View {
        VStack {
            GeometryReader { proxy in
                let screenSize = proxy.size
                
                VStack {
                    
                    // MARK: - My Playlists And Favorite Buttons
                    DynamicTabHeader(size: screenSize)
                    
                    PopularPlaylists()
                                        
                    // MARK: - TabView
                    TabView(selection: $currentTab) {
                        ForEach(sampleTabs) { tab in
                            PlaylistsList(playlists: tab == sampleTabs[0] ? vm.myPlaylists : vm.favoritePlaylists)
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
                    .ignoresSafeArea()
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .onAppear(perform: gestureManager.addGesture)
                    .onDisappear(perform: gestureManager.removeGesture)
                }
                .frame(width: screenSize.width, height: screenSize.height)
            }
        }
        
        // MARK: - NavigationBar
        .customNavigationTitle(title: "Playlists")
        .customBarButton(name: "edit", width: 32, height: 16, placement: .topBarTrailing) {
            print("Search")
        }
        .customBarButton(name: "add", width: 25, height: 17, placement: .topBarTrailing) {
            print("Search")
        }
    }
    
    // MARK: - Methods
    @ViewBuilder
    func DynamicTabHeader(size: CGSize) -> some View {
        VStack(alignment: .leading, spacing: 22) {
            
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
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
                                ForEach(Tab.allCases) { tab in
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
    func indexOf(tab: Tab) -> Int {
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

// MARK: - Enum
enum Tab: String, CaseIterable, Identifiable {
    case myPlaylists = "My Playlists"
    case favorite = "Favorites"
    
    var id: String { rawValue }
}

// MARK: - Tabs Array
var sampleTabs: [Tab] = Tab.allCases

// MARK: - Extension
extension View {
    @ViewBuilder
    func offsetX(completion: @escaping (CGFloat) -> ()) -> some View {
        self
            .overlay {
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: minX)
                        .onPreferenceChange(OffsetKey.self) { value in
                            completion(value)
                        }
                }
            }
    }
}

// MARK: - Struct
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
