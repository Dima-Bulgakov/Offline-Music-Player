//
//  ViewModel.swift
//  MusicApp23
//
//  Created by Dima on 19.12.2023.
//

import SwiftUI
import AVFAudio
import RealmSwift

class ViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var actionSheetVisible = false
    @Published var selectedDocument: Data?
    @Published var selectedDocumentName: String?
    @Published var isFilePresented = false
    
    @Published var audioPlayer: AVAudioPlayer?
    @Published var currentSong: SongModel? = nil
    @Published var currentSongIndex: Int? = nil
    @Published var isPlaying = false
    @Published var currentTime: TimeInterval = 0.0
    @Published var totalTime: TimeInterval = 0.0
    
    @ObservedResults(SongModel.self) var songData
    @Published var songs: [SongModel] = []
    
    // MARK: - Initializer
    init() {
        songs = Array(songData)
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
                songs.append(song)
            }
        } catch {
            print("Error adding song: \(error.localizedDescription)")
        }
    }
    
    func deleteSong(at indices: IndexSet) {
        do {
            let realm = try Realm()
            try realm.write {
                let songsToDelete = indices.compactMap { $0 < songs.count ? songs[$0] : nil }
                realm.delete(songsToDelete)
                songs = Array(realm.objects(SongModel.self))
            }
        } catch {
            print("Error deleting song: \(error.localizedDescription)")
        }
    }

    
//    func deleteSong(at indices: IndexSet) {
//        do {
//            let realm = try Realm()
//            try realm.write {
//                let songsToDelete = indices.compactMap { $0 < songs.count ? songs[$0] : nil }
//                realm.delete(songsToDelete)
//            }
//            songs = Array(realm.objects(SongModel.self))
//        } catch {
//            print("Error deleting song: \(error.localizedDescription)")
//        }
//    }
    
    // MARK: - Player Methods
    func updateProgress() {
        guard let player = audioPlayer else { return }
        currentTime = player.currentTime
    }
    
    func seekAudio(to time: TimeInterval) {
        audioPlayer?.currentTime = time
    }
    
    func setCurrentSong(_ song: SongModel?, index: Int?) {
        currentSong = song
        currentSongIndex = index
    }
    
    func playAudio(data: Data) {
        do {
            self.audioPlayer = try AVAudioPlayer(data: data)
            self.audioPlayer?.prepareToPlay()
            self.audioPlayer?.play()
            isPlaying = true
            totalTime = audioPlayer?.duration ?? 0.0 // Устанавливаем totalTime
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }

    
    func playPause() {
        if isPlaying {
            self.audioPlayer?.pause()
        } else {
            self.audioPlayer?.play()
        }
        isPlaying.toggle()
    }
    
    func stopAudio() {
        self.audioPlayer?.stop()
        self.audioPlayer = nil
    }
    
    func durationFormatted(_ duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: duration) ?? ""
    }
    
    // MARK: - Temporary Data
    var myPlaylists: [PlaylistModel] = [
        .init(img: "playlist1", name: "Music for car", count: 32, songs: []),
        .init(img: "playlist2", name: "Music for gym", count: 25, songs: []),
        .init(img: "playlist3", name: "Music for walking", count: 26, songs: []),
        .init(img: "playlist4", name: "Music for sad", count: 4, songs: []),
        .init(img: "playlist5", name: "Workout", count: 8, songs: []),
        .init(img: "playlist6", name: "Relax", count: 8, songs: []),
        .init(img: "playlist7", name: "Camping mood", count: 32, songs: []),
        .init(img: "playlist8", name: "New Year", count: 25, songs: []),
        .init(img: "playlist9", name: "Deep Calm", count: 26, songs: []),
        .init(img: "playlist10", name: "Electronic", count: 8, songs: []),
        .init(img: "playlist11", name: "Meditation", count: 8, songs: []),
        .init(img: "playlist12", name: "Classic", count: 8, songs: []),
        .init(img: "playlist13", name: "Rock 80s", count: 8, songs: [])
    ]
    
    var favoritePlaylists: [PlaylistModel] = [
        .init(img: "playlist3", name: "Music for walking", count: 25, songs: []),
        .init(img: "playlist5", name: "Workout", count: 8, songs: []),
        .init(img: "playlist7", name: "Camping mood", count: 8, songs: []),
        .init(img: "playlist9", name: "Deep Calm", count: 8, songs: []),
        .init(img: "playlist12", name: "Classic", count: 8, songs: [])
    ]
    
    var popularPlaylists: [PlaylistModel] = [
        .init(img: "playlist6", name: "Relax", count: 8, songs: []),
        .init(img: "playlist8", name: "New Year", count: 25, songs: []),
        .init(img: "playlist10", name: "Electronic", count: 8, songs: []),
        .init(img: "playlist11", name: "Meditation", count: 8, songs: []),
        .init(img: "playlist13", name: "Rock 80s", count: 8, songs: [])
    ]
}



