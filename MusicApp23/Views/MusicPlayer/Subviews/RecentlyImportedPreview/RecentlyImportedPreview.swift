//
//  RecentlyImported.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI
import RealmSwift


struct RecentlyImportedPreview: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @ObservedResults(Song.self) var songs

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
                
                /// "View All" Button
                NavigationLink(destination: RecentlyImportedView()) {
                    Text("View All")
                        .blueButtonFont()
                }
            }
            .padding(.horizontal)
            
            // MARK: - Songs
            ScrollView(.horizontal, showsIndicators: false) {
                
                LazyHGrid(rows: numberColumns, spacing: 20) {
                    ForEach(songs.prefix(16)) { song in

                        SongCell(songModel: song)
                            .onTapGesture {
                                vm.playAudio(data: song.data, playlist: Array(songs))
                                vm.setCurrentSong(song, index: songs.firstIndex(of: song))
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


// MARK: - Preview
#Preview {
    RecentlyImportedPreview()
        .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
        .environmentObject(RealmManager(name: "viewModel"))
        .environmentObject(ImportManager())
        .preferredColorScheme(.dark)
}
