//
//  ContentView.swift
//  MusicApp23
//
//  Created by Dima on 19.12.2023.
//

import SwiftUI
import AVFoundation
import RealmSwift

struct MusicPlayerView: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                
                // MARK: - Subviews
                Possibilities()
                
                Spacer()

                if vm.allSongs.isEmpty {
                    VStack {
                        NoSongs()
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    RecentlyImported()
                    if !vm.popularPlaylists.isEmpty {
                        PopularPlaylists()
                    }
                    
                    AllMusic()
                }
                Spacer()
            }
        }
        .background(Color.bg)
        .padding(.bottom, 140)
        .customNavigationTitle(title: "Music Player")
    }
}


#Preview {
    NavigationView {
        MusicPlayerView()
            .environmentObject(ViewModel())
            .environmentObject(VMImportManager())
            .preferredColorScheme(.dark)
    }
}

