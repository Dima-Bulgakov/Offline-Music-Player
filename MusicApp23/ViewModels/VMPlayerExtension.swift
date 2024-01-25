//
//  VMPlayerExtension.swift
//  MusicApp23
//
//  Created by Dima on 25.01.2024.
//

import Foundation
import AVFAudio

// MARK: - Player Methods
extension ViewModel {
    
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
}
