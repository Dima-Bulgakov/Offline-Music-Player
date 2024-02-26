//
//  MusicList.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI
import RealmSwift


struct MusicList: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var rm: RealmManager
    @ObservedResults(Song.self) var allSongs
    
    // MARK: - Body
    var body: some View {
        VStack {
            
            // MARK: - List Of All Songs
            List {
                ForEach(sortedAllSongs().filter({ song in
                    vm.searchAllMusic.isEmpty || song.artist?.localizedCaseInsensitiveContains(vm.searchAllMusic) ?? false
                })) { song in
                    if vm.isEditModeAllMusicShow {
                        SongCellWithDurationAndEditMode(songModel: song) {
                            vm.selectSong(songId: song.id)
                        }
                        .listRowBackground(Color.bg)
                    } else {
                        SongCellWithDuration(songModel: song)
                            .onTapGesture {
                                vm.playAudio(data: song.data, playlist: Array(sortedAllSongs()))
                                vm.setCurrentSong(song, index: sortedAllSongs().firstIndex(of: song))
                            }
                            .listRowBackground(Color.bg)
                    }
                }
                .onDelete(perform: $allSongs.remove)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .padding(.bottom, vm.isEditModeAllMusicShow ? 0 : 140)
            .ignoresSafeArea(.keyboard)
            
            // MARK: - Bottom Buttons For Edit Mode
            if vm.isEditModeAllMusicShow  {
                HStack {
                    ButtonForEditMode(name: "selectAll", width: 100) {
                        vm.selectAllCells(for: .songs)
                    }
                    Spacer()
                    ButtonForEditMode(name: "addTo", width: 80) {
                        vm.isShowChoosePlaylistView = true
                    }
                    .sheet(isPresented: $vm.isShowChoosePlaylistView) {
                        ChoosePlaylistView()
                    }
                    Spacer()
                    ButtonForEditMode(name: "delete", width: 75) {
                        vm.deleteSelectedSongs()
                        vm.isEditModeAllMusicShow = false
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top)
            }
        }
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
    MusicList()
        .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
        .environmentObject(RealmManager(name: "viewModel"))
        .environmentObject(ImportManager())
        .preferredColorScheme(.dark)
}
