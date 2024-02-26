//
//  NoSongs.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI


struct NoSongs: View {
    
    // MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            VStack {
                ZStack {
                    Circle()
                        .strokeBorder(Color.accent, lineWidth: 2)
                        .background(Circle().foregroundColor(.clear))
                        .frame(width: 146, height: 146)
                    Image("noSongs")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 85)
                        .foregroundColor(Color.accent)
                        .offset(x: -4, y: 4)
                }
                HStack {
                    VStack {
                        Text("Please import music")
                            .importButtonFont()
                        Text("to starting use the app")
                            .importButtonFont()
                    }
                    .padding(.top, 10)
                }
            }
            Spacer()
        }
        .frame(height: 400)
        .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}


// MARK: - Preview
#Preview {
    NoSongs()
        .preferredColorScheme(.dark)
}
