//
//  VMPlayerExtension.swift
//  MusicApp23
//
//  Created by Dima on 25.01.2024.
//

import Foundation
import AVFAudio
import MediaPlayer

// MARK: - Setting The Remote Control On A Locked Screen
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        application.beginReceivingRemoteControlEvents()
        return true
    }
}

// MARK: - Player Methods Extension
extension ViewModel {
    
    func updateProgress() {
        guard let player = audioPlayer else { return }
        currentTime = player.currentTime
    }
    
    func seekAudio(to time: TimeInterval) {
        audioPlayer?.currentTime = time
        notifyPlaybackProgressUpdated()
    }
    
    func setCurrentSong(_ song: SongModel?, index: Int?) {
        currentSong = song
        currentSongIndex = index
    }
    

    func playAudio(data: Data, playlist: [SongModel]) {
            do {
                self.audioPlayer = try AVAudioPlayer(data: data)
                self.audioPlayer?.delegate = self
                self.audioPlayer?.prepareToPlay()
                self.audioPlayer?.play()
                isPlaying = true
                totalTime = audioPlayer?.duration ?? 0.0
                
                if isRepeat {
                    self.audioPlayer?.numberOfLoops = -1
                } else {
                    self.audioPlayer?.numberOfLoops = 0
                }
                currentPlaylist = playlist
                /// Call "setupNowPlaying()" After Starting To Play A New Song
                updateNowPlayingInfo()
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        }
    
    func toggleRepeat() {
        isRepeat.toggle()
        if isRepeat {
            audioPlayer?.numberOfLoops = -1
        } else {
            audioPlayer?.numberOfLoops = 0
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
    
    func forward() {
        guard let audioPlayer = audioPlayer else { return }
        
        if isRepeat {
            audioPlayer.currentTime = 0
            audioPlayer.play()
        } else {
            if let currentIndex = currentSongIndex, currentIndex < currentPlaylist.count - 1 {
                currentSongIndex! += 1
            } else {
                currentSongIndex = 0
            }
            
            let song = currentPlaylist[currentSongIndex!]
            currentSong = song
            playAudio(data: song.data, playlist: currentPlaylist)
        }
    }
    
    func backward() {
        guard let audioPlayer = audioPlayer else { return }
        
        if isRepeat {
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
        if isShuffle {
            currentPlaylist = originalSongsOrder
            currentSongIndex = originalSongsOrder.firstIndex { $0 == currentSong }
        } else {
            currentPlaylist = currentPlaylist.shuffled()
            currentSongIndex = 0
            if let song = currentPlaylist.first {
                currentSong = song
                playAudio(data: song.data, playlist: currentPlaylist)
            }
        }
        isShuffle.toggle()
    }
    
    func reverseOrder() {
        allSongs = allSongs.reversed()
        currentSongIndex = allSongs.firstIndex { $0 == currentSong }
    }
    
    func durationFormatted(_ duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: duration) ?? ""
    }
    
    // MARK: - Lock Screen Remote Control Settings
    func setupRemoteTransportControls() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [unowned self] event in
            if !self.isPlaying {
                self.playPause()
                return .success
            }
            return .commandFailed
        }
        
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            if self.isPlaying {
                self.playPause()
                return .success
            }
            return .commandFailed
        }
        
        commandCenter.nextTrackCommand.isEnabled = true
        commandCenter.nextTrackCommand.addTarget { [unowned self] event in
            self.forward()
            return .success
        }
        
        commandCenter.previousTrackCommand.isEnabled = true
        commandCenter.previousTrackCommand.addTarget { [unowned self] event in
            self.backward()
            return .success
        }
        
        commandCenter.changeRepeatModeCommand.isEnabled = true
        commandCenter.changeRepeatModeCommand.addTarget { [unowned self] event in
            self.toggleRepeat()
            return .success
        }
        
        commandCenter.changeShuffleModeCommand.isEnabled = true
        commandCenter.changeShuffleModeCommand.addTarget { [unowned self] event in
            self.shuffleSongs()
            return .success
        }
        
        commandCenter.changePlaybackPositionCommand.isEnabled = true
        commandCenter.changePlaybackPositionCommand.addTarget { [unowned self] event in
            if let event = event as? MPChangePlaybackPositionCommandEvent {
                self.seekAudio(to: event.positionTime)
                return .success
            }
            return .commandFailed
        }
        
        /// Adding A Listener To Update Progress When A Notification Is Received
        NotificationCenter.default.addObserver(forName: .playbackProgressUpdated, object: nil, queue: nil) { [weak self] _ in
            self?.updateNowPlayingInfo()
        }
    }


    func updateNowPlayingInfo() {
        // Определяем информацию о текущем проигрываемом треке
        var nowPlayingInfo = [String: Any]()

        if let currentSong = currentSong {
            // Устанавливаем название трека
            nowPlayingInfo[MPMediaItemPropertyTitle] = currentSong.name

            // Добавляем обложку
            if let coverImageData = currentSong.coverImageData,
               let coverImage = UIImage(data: coverImageData) {
                let artwork = MPMediaItemArtwork(boundsSize: coverImage.size, requestHandler: { _ -> UIImage in
                    return coverImage
                })
                nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
                print("Обложка установлена успешно.")
            } else {
                print("Нет данных об обложке для текущей песни.")
            }
        } else {
            print("Не удалось получить данные из URL аудиоплеера.")
        }

        // Добавляем информацию о длительности песни и текущем времени воспроизведения
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = audioPlayer?.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = audioPlayer?.duration

        // Устанавливаем метаданные
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    /// Method To Notify The Remote On Locked Screen, That A Playback Progress Was Update
    func notifyPlaybackProgressUpdated() {
        NotificationCenter.default.post(name: .playbackProgressUpdated, object: self)
    }
}
