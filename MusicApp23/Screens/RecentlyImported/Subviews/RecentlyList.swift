//
//  RecentlyList.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct RecentlyList: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 14) {
                ForEach(vm.recentlyImported) { song in
                    HStack {
                        SongCellWithDuration(songModel: song)
                            .onTapGesture {
                                vm.playAudio(data: song.data, playlist: vm.recentlyImported)
                                vm.setCurrentSong(song, index: vm.recentlyImported.firstIndex(of: song))
                            }
                    }
                    .listRowBackground(Color.bg)
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(InsetListStyle())
    }
}

#Preview {
    RecentlyList()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
