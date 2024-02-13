//
//  NoSongs.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct NoSongs: View {
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Image("noSongs")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
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



#Preview {
    NoSongs()
        .preferredColorScheme(.dark)
}
