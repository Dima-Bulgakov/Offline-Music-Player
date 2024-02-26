//
//  Model.swift
//  MusicApp23
//
//  Created by Dima on 25.02.2024.
//

import Foundation
import RealmSwift


class Playlist: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var image: Data?
    @Persisted var numberOfListens: Int = 0
    @Persisted var songs: List<Song>

    var count: Int {
        return songs.count
    }

    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    convenience init(name: String, image: Data?) {
        self.init()
        self.name = name
        self.image = image
    }
}

class Song: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var data: Data
    @Persisted var artist: String?
    @Persisted var coverImageData: Data?
    @Persisted var duration: TimeInterval?
    @Persisted(originProperty: "songs") var playlist: LinkingObjects<Playlist>

    convenience init(name: String, data: Data, artist: String? = nil, coverImageData: Data? = nil, duration: TimeInterval? = nil) {
        self.init()
        self.name = name
        self.data = data
        self.artist = artist
        self.coverImageData = coverImageData
        self.duration = duration
    }
}
