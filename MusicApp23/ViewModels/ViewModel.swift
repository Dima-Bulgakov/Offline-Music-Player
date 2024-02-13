//
//  ViewModel.swift
//  MusicApp23
//
//  Created by Dima on 19.12.2023.
//

import SwiftUI
import AVFAudio
import RealmSwift

final class ViewModel: NSObject, ObservableObject {
    
    // MARK: - Properties
    
    /// Menu Mode
    @Published var isMenuVisible: Bool = false
    @Published var isShowSongMenu = false
    
    /// Edit Mode
    @Published var isEditModeFavoriteShow: Bool = false
    @Published var isEditModeAllMusicShow: Bool = false
    @Published var isEditModeInPlaylistShow: Bool = false
    @Published var isEditModePlaylistsShow: Bool = false
    @Published var isPlayerPresented: Bool = true
    
    /// Player
    @Published var audioPlayer: AVAudioPlayer?
    @Published var currentSong: SongModel? = nil
    @Published var currentSongIndex: Int? = nil
    @Published var currentTime: TimeInterval = 0.0
    @Published var totalTime: TimeInterval = 0.0
    @Published var isPlaying = false
    @Published var isShuffle: Bool = false
    @Published var isRepeat: Bool = false
    
    /// Searching
    @Published var searchAllMusic = ""
    @Published var searchRecently = ""
    @Published var filteredSongs: [SongModel] = []
    
    /// DataBase
    @ObservedResults(SongModel.self) var songData
    @Published var allSongs: [SongModel] = [] {
        didSet {
            recentlyImportedUpdate()
            myMusicSongsUpdate()
        }
    }
    @Published var originalSongsOrder: [SongModel] = []
    @Published var originalSongsOrderRecently: [SongModel] = []
    @Published var favoriteSongs: [SongModel] = []
    @Published var recentlyImported: [SongModel] = []
    @Published var popularPlaylists: [PlaylistModel] = []
    @Published var allPlaylists: [PlaylistModel] = [] {
        didSet {
            updatePopularPlaylists()
        }
    }
    
    /// Create Playlists And Add Songs To Playlists
    @Published var selectedSongs: [SongModel] = []
    @Published var currentPlaylist: [SongModel] = []
    @Published var isShowAddToPlaylistView = false
    @Published var isShowChoosePlaylistView = false
    
    /// Lock Screen
    private let audioSession = AVAudioSession.sharedInstance()
    
    // MARK: - Initializer
    override init() {
        super.init()
        allSongs = Array(songData)
        originalSongsOrder = allSongs
        originalSongsOrderRecently = recentlyImported
        popularPlaylists = allPlaylists
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to configure audio session:", error.localizedDescription)
        }
               
        try! self.audioSession.setActive(true)
        
        setupRemoteTransportControls()
//        setupNowPlaying()
    }
    
    // MARK: - Realm Methods
    func addSong(name: String, data: Data, artist: String?, coverImageData: Data?, duration: TimeInterval?) {
        let realm = try! Realm()
        
        do {
            try realm.write {
                let song = SongModel()
                song.name = name
                song.artist = artist
                song.coverImageData = coverImageData
                song.data = data
                song.duration = duration
                realm.add(song)
                allSongs.append(song)
            }
        } catch {
            print("Error adding song: \(error.localizedDescription)")
        }
    }
    
    func deleteSong(at indices: IndexSet) {
        do {
            let realm = try Realm()
            try realm.write {
                let songsToDelete = indices.compactMap { $0 < allSongs.count ? allSongs[$0] : nil }
                realm.delete(songsToDelete)
                allSongs = Array(realm.objects(SongModel.self))
            }
        } catch {
            print("Error deleting song: \(error.localizedDescription)")
        }
    }
    
    // TODO: Add Realm To This Method
    func addToFavorites() {
        guard let currentSong = currentSong else { return }
        if !favoriteSongs.contains(currentSong) {
            favoriteSongs.append(currentSong)
        }
    }
    
    // MARK: - Searching Method
    func searchSongsByArtist() {
        guard !searchAllMusic.isEmpty else {
            filteredSongs = originalSongsOrder
            return
        }
        
        filteredSongs = originalSongsOrder.filter { song in
            if let artist = song.artist {
                return artist.localizedCaseInsensitiveContains(searchAllMusic)
            } else {
                return false
            }
        }
    }

    func searchSongsByArtistRecently() {
        guard !searchRecently.isEmpty else {
            recentlyImported = originalSongsOrderRecently
            return
        }
        
        recentlyImported = originalSongsOrderRecently.filter { song in
            if let artist = song.artist {
                return artist.localizedCaseInsensitiveContains(searchRecently)
            } else {
                return false
            }
        }
    }

    // MARK: - Playlist Methods
    func isSelectedPlaylist(playlist: PlaylistModel) {
        if let index = allPlaylists.firstIndex(where: { $0.id == playlist.id }) {
            var newTask = playlist
            newTask.isSelected.toggle()
            allPlaylists[index] = newTask
        }
    }
 
    func resetPlaylistSelection() {
        for index in allPlaylists.indices {
            allPlaylists[index].isSelected = false
        }
    }
    
    func selectAllPlaylists() {
        let allSelected = allPlaylists.allSatisfy { $0.isSelected }
        
        for index in allPlaylists.indices {
            allPlaylists[index].isSelected = !allSelected
        }
    }
    
    func deleteSelectedPlaylists() {
        allPlaylists.removeAll { $0.isSelected }
    }
    
    // MARK: - Into Playlist Methods
    func selectSongsInPlaylist(model: PlaylistModel) {
            let allSelected = model.songs.allSatisfy { $0.isSelected }

            for index in model.songs.indices {
                model.songs[index].isSelected = !allSelected
            }
        }
    func deleteSelectedSongsFromPlaylist(model: PlaylistModel) {
        let selectedIndices = model.songs.indices.filter { model.songs[$0].isSelected }
        deleteSongsFromPlaylist(at: IndexSet(selectedIndices), playlist: model)
    }
    func deleteSongsInPlaylist(at offsets: IndexSet, model: PlaylistModel) {
        // Вызываем метод в вашей ViewModel для удаления песен по индексам
        deleteSongsFromPlaylist(at: offsets, playlist: model)
    }
    
    // MARK: - Songs Methods
    func addSelectedSongsToPlaylists() {
        let selectedPlaylists = allPlaylists.filter { $0.isSelected }
        
        for playlist in selectedPlaylists {
            var updatedPlaylist = playlist
            
            if let currentSong = currentSong, selectedSongs.isEmpty {
                updatedPlaylist.songs.append(currentSong)
            }
            
            for song in selectedSongs {
                if !updatedPlaylist.songs.contains(where: { $0.id == song.id }) {
                    updatedPlaylist.songs.append(song)
                }
            }
            
            if let index = allPlaylists.firstIndex(where: { $0.id == playlist.id }) {
                allPlaylists[index] = updatedPlaylist
            }
        }
        selectedSongs.removeAll()
    }
    
    func deleteSongsFromPlaylist(at indices: IndexSet, playlist: PlaylistModel) {
        guard let playlistIndex = allPlaylists.firstIndex(where: { $0.id == playlist.id }) else { return }
        allPlaylists[playlistIndex].songs.remove(atOffsets: indices)
    }
    
    func isSelectedSongInArrays(model: SongModel, playlist: inout [SongModel]) {
        if let index = playlist.firstIndex(where: { $0.id == model.id }) {
            let newTask = model
            newTask.isSelected.toggle()
            playlist[index] = newTask
        }
    }
    
    func isSelectedSongInPlaylists(song: SongModel) {
        if let index = allSongs.firstIndex(where: { $0.id == song.id }) {
            let newTask = song
            newTask.isSelected.toggle()
            allSongs[index] = newTask
        }
    }
    
    func selectAllSongs() {
        let allSelected = allSongs.allSatisfy { $0.isSelected }
        
        for index in allSongs.indices {
            allSongs[index].isSelected = !allSelected
        }
    }
    
    func unselectSongs() {
        for index in allSongs.indices {
            allSongs[index].isSelected = false
        }
    }
    
    func deleteSelectedSongsFromFavorites() {
        favoriteSongs.removeAll { $0.isSelected }
    } 
}
