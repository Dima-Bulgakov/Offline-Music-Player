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
    @EnvironmentObject var rm: RealmManager
    
    // MARK: - Body
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                
                // MARK: - Subviews
                PossibilitiesPreview()
                if let isNotEmpty = rm.songs?.isEmpty, isNotEmpty {
                    NoSongs()
                        .offset(y: -40)
                } else {
                    RecentlyImportedPreview()
                    if !rm.playlistsArray.isEmpty {
                        PopularPlaylistsPreview()
                    }
                    AllMusicPreview()
                }
                Spacer()
            }
        }
        .background(Color.bg)
        .padding(.bottom, 140)
        
        // MARK: - Navigation Bar
        .customNavigationTitle(title: "Music Player")
    }
}


// MARK: - Preview
#Preview {
    NavigationView {
        MusicPlayerView()
            .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
            .environmentObject(RealmManager(name: "viewModel"))
            .environmentObject(ImportManager())
            .preferredColorScheme(.dark)
    }
}
