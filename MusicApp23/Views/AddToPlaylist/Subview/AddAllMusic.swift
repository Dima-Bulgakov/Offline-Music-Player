//
//  AddAllMusic.swift
//  MusicApp23
//
//  Created by Dima on 06.01.2024.
//

import SwiftUI

struct AddAllMusic: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        List {
            ForEach(vm.allSongs) { song in
                AddMusicItem(songModel: song) {
                    vm.isSelectedSongInArrays(model: song, playlist: &vm.allSongs)
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    AddAllMusic()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
