//
//  AudioPlayerDelegate+Extension.swift
//  MusicApp23
//
//  Created by Dima on 19.01.2024.
//

import Foundation
import AVFoundation

// MARK: - Для отслеживания завершения песни и переключения на следущую
extension ViewModel: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        forward()
    }
}
