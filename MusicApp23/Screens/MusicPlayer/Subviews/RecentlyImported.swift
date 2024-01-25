//
//  RecentlyImported.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI

struct RecentlyImported: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    private let numberColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .center) {
                
                // MARK: - Title
                Text("Recently Imported")
                    .titleFont()
                Spacer()
                
                // MARK: - View All Button
                NavigationLink(destination: RecentlyImportedView()) {
                    Text("View All")
                        .blueButtonFont()
                }
            }
            .padding(.horizontal)
            
            // MARK: - Songs
            ScrollView(.horizontal, showsIndicators: false) {
                
                LazyHGrid(rows: numberColumns, spacing: 20) {
                    ForEach(vm.recentlyImported) { song in
                        
                        SongCell(songModel: song)
                            .onTapGesture {
                                vm.playAudio(data: song.data, playlist: vm.recentlyImported)
                                vm.setCurrentSong(song, index: vm.recentlyImported.firstIndex(of: song))
                            }
                            .frame(width: 210, alignment: .leading)
                    }
                }
                .offset(x: 16)
            }
            .frame(height: 130)
        }
        .padding(.vertical)
    }
}

#Preview {
    RecentlyImported()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
