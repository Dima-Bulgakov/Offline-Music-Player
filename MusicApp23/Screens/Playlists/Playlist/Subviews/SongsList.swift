//
//  SongsList.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct SongsList: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        List {
            ForEach(vm.songs) { song in
                HStack {
                    ArtistCellWithDuration(songModel: song)
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(InsetListStyle())
    }
}

#Preview {
    SongsList()
        .environmentObject(ViewModel())
}
