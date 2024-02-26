//
//  ViewModel.swift
//  MusicApp23
//
//  Created by Dima on 25.02.2024.
//

import Foundation
import RealmSwift
import AVFAudio
import GCDWebServer
import MediaPlayer


// MARK: - Enum For Selec All Cells In AllSongs, Favorite or Playlist
enum SelectionType {
    case songs
    case playlists
    case favorites
}

// MARK: - Enum For Sorting Songs
enum SortType {
    case name
    case artist
    case duration
    case date
    case reverse
}


final class ViewModel: NSObject, ObservableObject {
    
    // MARK: - Properties
    var rm: RealmManager
    
    /// Menu Mode
    @Published var selectedView: Int = 1
    @Published var isMenuVisible: Bool = false
    @Published var isShowSongMenu = false
    @Published var isShowSortMenuAllMusic = false
    @Published var isShowSortMenuRecentlyImported = false
    @Published var isShowSortMenuPlaylist = false
    
    /// Edit Mode
    @Published var isEditModeFavoriteShow: Bool = false
    @Published var isEditModeAllMusicShow: Bool = false
    @Published var isEditModeInPlaylistShow: Bool = false
    @Published var isEditModePlaylistsShow: Bool = false
    
    /// Player
    @Published var isPlayerPresented: Bool = true
    @Published var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    
    @Published var currentTime: TimeInterval = 0.0
    @Published var totalTime: TimeInterval = 0.0
    
    @Published var isRepeatModeEnabled: Bool = false
    @Published var isShuffleModeEnabled: Bool = false
    @Published var isReverseAllMusicEnable: Bool = false
    @Published var isReverseRecentlyMusicEnable: Bool = false
    @Published var isReversePlaylistMusicEnable: Bool = false
    
    /// Current Song
    @Published var currentSong: Song? = nil
    @Published var currentSongIndex: Int? = nil
    
    /// Song's And Playlist's Arrays
    @Published var currentPlaylist: [Song] = []
    @Published var selectedPlaylists = Set<ObjectId>()
    @Published var selectedSongs: Set<ObjectId> = []
    
    /// Searching
    @Published var searchAllMusic = ""
    @Published var searchRecently = ""
    
    /// Properties For Open Sheet For Add Songs To Playlists
    @Published var isShowAddToPlaylistView = false
    @Published var isShowChoosePlaylistView = false
    
    /// Sorting
    @Published var currentSortAllSongs: SortType = .name
    @Published var currentSortRecently: SortType = .name
    @Published var currentSortPlaylist: SortType = .name
    
    /// Property To Configure The Audio Session For Audio Playback:
    private let audioSession = AVAudioSession.sharedInstance()
    
    
    // MARK: - Initializer
    init(realmManager: RealmManager) {
        self.rm = realmManager
        super.init()
        self.setupAudioSession()
        self.setupRemoteTransportControls()
    }

    
    // MARK: - Player Methods
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("AudioSession setup failed: \(error)")
        }
    }
    
    func playAudio(data: Data, playlist: [Song]) {
        do {
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            isPlaying = true
            totalTime = audioPlayer?.duration ?? 0.0
            currentPlaylist = playlist
            DispatchQueue.main.async {
                self.updateNowPlayingInfo()
            }
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    func setCurrentSong(_ song: Song?, index: Int?) {
        currentSong = song
        currentSongIndex = index
        print("Set current song")
        updateNowPlayingInfo()
        notifyPlaybackProgressUpdated()
    }
    
    func playPause() {
        guard let audioPlayer = audioPlayer else { return }
        
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        } else {
            audioPlayer.play()
        }
        isPlaying.toggle()
        updateNowPlayingInfo()
    }
    
    func stopPlayback() {
        audioPlayer?.stop()
        isPlaying = false
        currentTime = 0.0
    }
    
    func forward() {
        guard let audioPlayer = audioPlayer else { return }
        
        if isRepeatModeEnabled {
            audioPlayer.currentTime = 0
            audioPlayer.play()
        } else if isShuffleModeEnabled {
            shuffleSongs()
        } else {
            if let currentIndex = currentSongIndex, currentIndex < currentPlaylist.count - 1 {
                setCurrentSong(currentPlaylist[currentIndex + 1], index: currentIndex + 1)
            } else {
                setCurrentSong(currentPlaylist.first, index: 0)
            }
            if let data = currentSong?.data {
                playAudio(data: data, playlist: currentPlaylist)
            }
        }
    }
    
    func backward() {
        guard let audioPlayer = audioPlayer else { return }
        
        if isRepeatModeEnabled {
            audioPlayer.currentTime = 0
            audioPlayer.play()
        } else {
            if let currentIndex = currentSongIndex, currentIndex > 0 {
                currentSongIndex! -= 1
            } else {
                currentSongIndex = currentPlaylist.count - 1
            }
            
            let song = currentPlaylist[currentSongIndex!]
            currentSong = song
            playAudio(data: song.data, playlist: currentPlaylist)
        }
    }
    
    func shuffleSongs() {
        guard !currentPlaylist.isEmpty else { return }
        let nextIndex = Int.random(in: 0..<currentPlaylist.count)
        setCurrentSong(currentPlaylist[nextIndex], index: nextIndex)
        playAudio(data: currentPlaylist[nextIndex].data, playlist: currentPlaylist)
    }
    
    func repeatSong() {
        isRepeatModeEnabled.toggle()
        if isRepeatModeEnabled {
            audioPlayer?.numberOfLoops = -1
        } else {
            audioPlayer?.numberOfLoops = 0
        }
    }
    
    func updateProgress() {
        guard let player = audioPlayer else { return }
        currentTime = player.currentTime
    }
    
    func seekAudio(to time: TimeInterval) {
        audioPlayer?.currentTime = time
        updateNowPlayingInfo()
        notifyPlaybackProgressUpdated()
    }
    
    func durationFormatted(_ duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: duration) ?? ""
    }
    
    // MARK: - Methods To Select Or Unselect Cells
    func selectSong(songId: ObjectId) {
        if selectedSongs.contains(songId) {
            selectedSongs.remove(songId)
        } else {
            selectedSongs.insert(songId)
        }
    }
    
    func selectPlaylist(playlist: Playlist) {
        if selectedPlaylists.contains(playlist.id) {
            selectedPlaylists.remove(playlist.id)
        } else {
            selectedPlaylists.insert(playlist.id)
        }
    }
    
    /// Select All Cells In Favorite, Songs Or Playlists
    func selectAllCells(for type: SelectionType) {
        switch type {
        case .songs:
            let allSongsIds = Set(rm.songs?.map { $0.id } ?? [])
            selectedSongs = selectedSongs == allSongsIds ? [] : allSongsIds
        case .playlists:
            let allPlaylistIds = Set(rm.playlists?.filter("name != %@", "Favorite").map { $0.id } ?? [])
            selectedPlaylists = selectedPlaylists == allPlaylistIds ? [] : allPlaylistIds
        case .favorites:
            guard let favoritePlaylist = rm.favoritePlaylist else { return }
            let favoriteSongsIds = Set(favoritePlaylist.songs.map { $0.id })
            selectedSongs = selectedSongs.isSuperset(of: favoriteSongsIds) ? [] : favoriteSongsIds
        }
    }
    
    func unselectAllSongs() {
        selectedSongs.removeAll()
    }
    
    func unselectAllPlaylists() {
        selectedPlaylists.removeAll()
    }
    
    // MARK: - Methods For Add Music To Playlists
    func addCurrentSongToFavorites() {
        guard let song = currentSong else { return }
        rm.addSongToFavorites(song)
        isShowSongMenu = false
    }
    
    func addCurrentSongToPlaylists() {
        guard let currentSong = currentSong else { return }
        selectedPlaylists.removeAll()
        selectedSongs = [currentSong.id]
        isShowChoosePlaylistView = true
    }
    
    func addSelectedSongToPlaylist() {
        for playlistId in selectedPlaylists {
            guard let playlist = rm.playlists?.first(where: { $0.id == playlistId }) else { continue }
            for songId in selectedSongs {
                guard let song = rm.songs?.first(where: { $0.id == songId }) else { continue }
                rm.addSongToPlaylist(song: song, playlist: playlist)
            }
        }
        selectedSongs.removeAll()
        selectedPlaylists.removeAll()
    }
    
    // MARK: - Methods For Delete Cells
    func deleteSelectedSongs() {
        rm.deleteSongs(withIDs: selectedSongs)
        selectedSongs.removeAll()
    }
    
    func deleteSelectedPlaylists() {
        rm.deletePlaylists(withIDs: selectedPlaylists)
        selectedPlaylists.removeAll()
        isEditModePlaylistsShow = false
        isPlayerPresented = true
    }
    
    func deleteSelectedFavorites() {
        for songId in selectedSongs {
            rm.removeSongFromFavorite(songId: songId)
        }
        selectedSongs.removeAll()
    }
    
    func deleteCurrentSong() {
        guard let songToDelete = currentSong else { return }
        if songToDelete.id == currentSong?.id {
            stopPlayback()
        }
        rm.deleteSong(songId: songToDelete.id)
        currentSong = nil
        isShowSongMenu = false
    }
    
    // MARK: - Lock Screen Remote Control Settings
    func setupRemoteTransportControls() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        /// Play Command
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [weak self] event in
            guard let self = self else { return .commandFailed }
            self.playPause()
            return .success
        }
        
        /// Pause Command
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { [weak self] event in
            guard let self = self else { return .commandFailed }
            self.playPause()
            return .success
        }
        
        /// Next Track Command
        commandCenter.nextTrackCommand.isEnabled = true
        commandCenter.nextTrackCommand.addTarget { [weak self] event in
            guard let self = self else { return .commandFailed }
            self.forward()
            return .success
        }
        
        /// Previous Track Command
        commandCenter.previousTrackCommand.isEnabled = true
        commandCenter.previousTrackCommand.addTarget { [weak self] event in
            guard let self = self else { return .commandFailed }
            self.backward()
            return .success
        }
        
        /// Change Repeat Mode Command
        commandCenter.changeRepeatModeCommand.isEnabled = true
        commandCenter.changeRepeatModeCommand.addTarget { [weak self] event in
            guard let self = self else { return .commandFailed }
            self.repeatSong()
            return .success
        }
        
        /// Change Shuffle Mode Command
        commandCenter.changeShuffleModeCommand.isEnabled = true
        commandCenter.changeShuffleModeCommand.addTarget { [weak self] event in
            guard let self = self else { return .commandFailed }
            self.shuffleSongs()
            return .success
        }
        
        /// Change Playback Position Command
        commandCenter.changePlaybackPositionCommand.isEnabled = true
        commandCenter.changePlaybackPositionCommand.addTarget { [weak self] event in
            guard let self = self, let event = event as? MPChangePlaybackPositionCommandEvent else {
                return .commandFailed
            }
            self.seekAudio(to: event.positionTime)
            return .success
        }
    }
    
    /// Update Information About Song
    func updateNowPlayingInfo() {
        var nowPlayingInfo = [String: Any]()
        
        if let currentSong = currentSong {
            nowPlayingInfo[MPMediaItemPropertyTitle] = currentSong.name
            
            if let coverImageData = currentSong.coverImageData,
               let coverImage = UIImage(data: coverImageData) {
                let artwork = MPMediaItemArtwork(boundsSize: coverImage.size, requestHandler: { _ -> UIImage in
                    return coverImage
                })
                nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
                print("The cover installed successfully.")
            } else {
                print("No cover data for current song.")
            }
        } else {
            print("Failed to get data from audio player URL.")
        }
        
        /// Add information about song duration and current playback time
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = audioPlayer?.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = audioPlayer?.duration
        
        /// Set metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    /// Method To Notify The Remote On Locked Screen, That A Playback Progress Was Update
    func notifyPlaybackProgressUpdated() {
        NotificationCenter.default.post(name: .playbackProgressUpdated, object: self)
    }
}


// MARK: - Setting The Remote Control On A Locked Screen
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        application.beginReceivingRemoteControlEvents()
        return true
    }
}


// MARK: - To Track The End Of A Song And Switch To The Next Song
extension ViewModel: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        forward()
    }
}


// MARK: - Extension For Remote Control Progress Notification On Locked Screen
extension Notification.Name {
    static let playbackProgressUpdated = Notification.Name("playbackProgressUpdated")
}
