//
//  RecentlyList.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI
import RealmSwift


struct RecentlyImportedList: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @ObservedResults(Song.self) var allSongs
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 14) {
                
                // MARK: List Of Songs
                ForEach(sortedRecentlySongs().filter({ song in
                    vm.searchRecently.isEmpty || song.artist?.localizedCaseInsensitiveContains(vm.searchRecently) ?? false
                })) { song in
                    SongCellWithDuration(songModel: song)
                        .onTapGesture {
                            vm.playAudio(data: song.data, playlist: Array(sortedRecentlySongs()))
                            vm.setCurrentSong(song, index: sortedRecentlySongs().firstIndex(of: song))
                        }
                        .listRowBackground(Color.bg)
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(InsetListStyle())
    }
    
    // MARK: - Methods
    private func sortedRecentlySongs() -> [Song] {
        let songsArray = Array(allSongs.prefix(16))
        switch vm.currentSortRecently {
        case .name:
            return songsArray.sorted(by: { $0.name < $1.name })
        case .artist:
            return songsArray.sorted(by: { ($0.artist ?? "") < ($1.artist ?? "") })
        case .duration:
            return songsArray.sorted(by: { ($0.duration ?? 0) < ($1.duration ?? 0) })
        case .date:
            return songsArray
        case .reverse:
            return vm.isReverseRecentlyMusicEnable ? songsArray.reversed() : songsArray
        }
    }
}


// MARK: - Preview
#Preview {
    RecentlyImportedList()
        .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
        .environmentObject(RealmManager(name: "viewModel"))
        .environmentObject(ImportManager())
        .preferredColorScheme(.dark)
}
