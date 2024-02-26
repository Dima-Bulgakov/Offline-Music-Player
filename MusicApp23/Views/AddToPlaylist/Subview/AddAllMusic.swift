//
//  AddAllMusic.swift
//  MusicApp23
//
//  Created by Dima on 06.01.2024.
//

import SwiftUI
import RealmSwift


struct AddAllMusic: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @ObservedResults(Song.self) var allSongs
    
    // MARK: - Body
    var body: some View {
        List {
            ForEach(allSongs) { song in
                SongCellWithDurationAndEditMode(songModel: song) {
                    vm.selectSong(songId: song.id)
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
    }
}

