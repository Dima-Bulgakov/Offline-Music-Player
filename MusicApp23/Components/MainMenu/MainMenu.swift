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


// MARK: - Menu List
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

// MARK: - Corner Radius For Three Corners
struct RoundedCorners: Shape {
    
    // MARK: Properties
    var cornerRadius: CGFloat
    var corners: UIRectCorner
    
    // MARK: Methods
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let topLeft = corners.contains(.topLeft)
        let topRight = corners.contains(.topRight)
        let bottomLeft = corners.contains(.bottomLeft)
        let bottomRight = corners.contains(.bottomRight)
        
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width, y: height - cornerRadius))
        
        if topRight {
            path.addArc(center: CGPoint(x: width - cornerRadius, y: height - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        } else {
            path.addLine(to: CGPoint(x: width, y: height - cornerRadius))
        }
        
        if topLeft {
            path.addArc(center: CGPoint(x: cornerRadius, y: height - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        } else {
            path.addLine(to: CGPoint(x: 0, y: height))
        }
        
        if bottomLeft {
            path.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        } else {
            path.addLine(to: CGPoint(x: 0, y: 0))
        }
        
        if bottomRight {
            path.addArc(center: CGPoint(x: width - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 0), clockwise: false)
        } else {
            path.addLine(to: CGPoint(x: width, y: 0))
        }
        
        return path
    }
}

// MARK: - Menu Item
struct MenuItem: View {
    
    // MARK: Properties
    let image: String
    let title: String
    
    // MARK: Body
    var body: some View {
        VStack {
            HStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .padding(.trailing, 10)
                Text(title)
            }
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    MainMenu()
        .environmentObject(ViewModel())
}
