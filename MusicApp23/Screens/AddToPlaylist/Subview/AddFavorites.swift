//
//  AddFavorites.swift
//  MusicApp23
//
//  Created by Dima on 06.01.2024.
//

import SwiftUI

struct AddFavorites: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        List {
            ForEach(vm.favoriteSongs) { song in
                AddMusicItem(songModel: song) {
//                    vm.isSelectedSong(song: song)
                    vm.isSelectedSongInArrays(model: song, playlist: &vm.favoriteSongs)
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    AddFavorites()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}

