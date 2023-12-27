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
    @State var selectedRow = Set<UUID>()
    
    // MARK: - Body
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                // MARK: - Subviews
                Possibilities()
                
                Spacer()
                
                if vm.songs.isEmpty {
                    VStack {
                        Spacer(minLength: 150)
                        NoSongs()
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    RecentlyImported()
                    PopularPlaylists()
                    AllMusic()
                }
                
                Spacer()
            }
            .customBarButton(name: "magnifyingglass", width: 19, height: 19, placement: .topBarTrailing) {  }
        }
        .padding(.bottom, 130)
    }
}


#Preview {
    NavigationView {
        MusicPlayerView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
    }
}

