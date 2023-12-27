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
                ForEach(vm.songs.prefix(12)) { song in
                    HStack {
                        ArtistCellWithDuration(songModel: song)
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
