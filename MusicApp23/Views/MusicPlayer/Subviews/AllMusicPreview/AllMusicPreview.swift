//
//  AllMusic.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI
import RealmSwift


struct AllMusicPreview: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @ObservedResults(Song.self) var allSongs
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .center) {
                
                // MARK: - Title
                Text("All Music")
                    .titleFont()
                Spacer()
                
                /// "View All" Button
                Button {
                    vm.selectedView = 2 // Изменение selectedView на 2 при нажатии на кнопку
                } label: {
                    Text("View All")
                        .blueButtonFont()
                }
            }
            
            // MARK: - Shuffle and Sort Buttons
            HStack(spacing: 16) {
                ShuffleButton()
                SortButtonAllMusic()
            }
            
            // MARK: - List of Songs
            ScrollView {
                LazyVStack(spacing: 14) {
                    ForEach(sortedAllSongs().prefix(16)) { song in
                        HStack {
                            SongCellWithDuration(songModel: song)
                                .onTapGesture {
                                    vm.playAudio(data: song.data, playlist: Array(allSongs))
                                    vm.setCurrentSong(song, index: allSongs.firstIndex(of: song))
                                }
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
    
    // MARK: - Methods
    private func sortedAllSongs() -> [Song] {
        let songsArray = Array(allSongs)
        switch vm.currentSortAllSongs {
        case .name:
            return songsArray.sorted(by: { $0.name < $1.name })
        case .artist:
            return songsArray.sorted(by: { ($0.artist ?? "") < ($1.artist ?? "") })
        case .duration:
            return songsArray.sorted(by: { ($0.duration ?? 0) < ($1.duration ?? 0) })
        case .date:
            return songsArray
        case .reverse:
            return vm.isReverseAllMusicEnable ? songsArray.reversed() : songsArray
        }
    }
}


// MARK: - Preview
#Preview {
    AllMusicPreview()
        .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
        .environmentObject(RealmManager(name: "viewModel"))
        .environmentObject(ImportManager())
        .preferredColorScheme(.dark)
}
