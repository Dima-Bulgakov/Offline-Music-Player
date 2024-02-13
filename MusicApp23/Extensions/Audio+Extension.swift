//
//  Audio+Extension.swift
//  MusicApp23
//
//  Created by Dima on 13.02.2024.
//

import Foundation
import AVFoundation

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
