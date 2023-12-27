//
//  AllMusic.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct AllMusic: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .bottom) {
                
                // MARK: - Title
                Text("All Music")
                    .titleFont()
                Spacer()
                
                // MARK: - View All Button
                NavigationLink(destination: MyMusicView()) {
                    Text("View All")
                        .blueButtonFont()
                }
            }
            
            // MARK: - Shuffle and Sort Buttons
            HStack(spacing: 16) {
                ShuffleButton()
                SortButton()
            }
            
            // MARK: - List of Songs
            ScrollView {
                LazyVStack(spacing: 14) {
                    ForEach(vm.songs.prefix(15)) { song in
                        HStack {
                            ArtistCellWithDuration(songModel: song)
                        }
                        .listRowBackground(Color.bg)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding(.horizontal)
    }
}

#Preview {
    AllMusic()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
