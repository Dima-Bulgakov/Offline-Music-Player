//
//  SongModel.swift
//  MusicApp23
//
//  Created by Dima on 19.12.2023.
//

import Foundation
import RealmSwift

// MARK: - Model
final class SongModel: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var data: Data
    @Persisted var artist: String?
    @Persisted var coverImageData: Data?
    @Persisted var duration: TimeInterval?
    
    override class func primaryKey() -> String? {
        "id"
    }

    convenience override init() {
        self.init(name: "", data: Data())
    }

    init(name: String, data: Data, artist: String? = nil, coverImageData: Data? = nil) {
        self.name = name
        self.data = data
        self.artist = artist
        self.coverImageData = coverImageData
        super.init()
    }
}

import AVFoundation
// MARK: - Temporary Model
struct PlaylistModel: Identifiable {
    let id = UUID()
    let img : String
    let name : String
    let count : Int
    var songs: [TrackModel]
}

struct TrackModel: Identifiable {
    let id = UUID()
    let img: String
    let name: String
    let artist: String
    let songFile: String
    var duration: TimeInterval?

    init(img: String, name: String, artist: String, songFile: String) {
        self.img = img
        self.name = name
        self.artist = artist
        self.songFile = songFile
        self.duration = loadDuration()
    }

    func loadDuration() -> TimeInterval? {
        guard let sound = Bundle.main.path(forResource: songFile, ofType: "mp3") else {
            return nil
        }

        let asset = AVURLAsset(url: URL(fileURLWithPath: sound))
        let durationInSeconds = CMTimeGetSeconds(asset.duration)
        return durationInSeconds.isFinite ? durationInSeconds : nil
    }
}


