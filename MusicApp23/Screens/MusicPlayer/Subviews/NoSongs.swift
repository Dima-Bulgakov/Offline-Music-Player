//
//  NoSongs.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct NoSongs: View {
    
    // MARK: - Properties
    var body: some View {
        VStack {
            
            // MARK: - Image
            Image("noSongs")
                .resizable()
                .scaledToFit()
                .frame(width: 202, height: 202)
            
            // MARK: - Description
            HStack {
                VStack {
                    HStack {
                        Text("Please")
                            .importButtonFont()
                        NavigationLink(destination: WelcomeView()) {
                            Text("import")
                                .importLinkFont()
                        }
                        Text("music")
                            .importButtonFont()
                    }
                    Text("to starting use the app")
                        .importButtonFont()
                }
                .padding(.top, 25)
            }
        }
    }
}

#Preview {
    NoSongs()
        .preferredColorScheme(.dark)
}
