//
//  RealmManager.swift
//  MusicApp23
//
//  Created by Dima on 25.02.2024.
//

import Foundation
import RealmSwift
import AVFAudio
import GCDWebServer


final class RealmManager: ObservableObject {
    
    // MARK: - Properties
    private(set) var realm: Realm?
    private var songsToken: NotificationToken?
    
    @Published var songs: Results<Song>?
    @Published var playlists: Results<Playlist>?
    
    var playlistsArray: [Playlist] {
        if let playlists = playlists {
            return playlists.filter { $0.name != "Favorite" }.sorted(by: { $0.name < $1.name })
        } else {
            return []
        }
    }
    
    var favoritePlaylist: Playlist? {
        return playlists?.filter("name == 'Favorite'").first
    }
    
    private var countriesToken: NotificationToken?
    
    
    // MARK: - Initialization
    init(name: String) {
        openRealm()
        setupObserver()
        loadPlaylists()
    }
    
    deinit {
        songsToken?.invalidate()
    }
    
    
    // MARK: - Methods
    private func loadPlaylists() {
        guard let realm = realm else { return }
        playlists = realm.objects(Playlist.self).sorted(byKeyPath: "name", ascending: true)
    }
    
    private func openRealm() {
        let config = Realm.Configuration(
            fileURL: FileManager.default
                .containerURL(forSecurityApplicationGroupIdentifier: "group.OMP")?
                .appendingPathComponent("SharedRealm.realm"),
            schemaVersion: 1, /// current version of the data migration scheme
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                }
            }
        )
        
        /// Applying the default configuration
        Realm.Configuration.defaultConfiguration = config
        
        /// Attempting to open Realm with a given configuration
        do {
            realm = try Realm(configuration: config)
            
            /// Adding a "Favorite" playlist if it does not already exist
            if let realm = realm {
                try realm.write {
                    if realm.objects(Playlist.self).filter("name == 'Favorite'").isEmpty {
                        let myFavoritePlaylist = Playlist(name: "Favorite")
                        realm.add(myFavoritePlaylist)
                    }
                }
            }
        } catch {
            print("Error opening Realm: \(error)")
        }
    }
    
    private func setupObserver() {
        guard let realm = realm else { return }
        
        let observedSongs = realm.objects(Song.self).sorted(byKeyPath: "name", ascending: true)
        
        songsToken = observedSongs.observe { [weak self] (changes: RealmCollectionChange) in
            DispatchQueue.main.async {
                switch changes {
                case .initial(let results), .update(let results, _, _, _):
                    self?.songs = results
                case .error(let error):
                    print("Error in observing song changes: \(error)")
                }
            }
        }
    }
    
    // MARK: - Create
    func addSong(name: String, data: Data, artist: String?, coverImageData: Data?, duration: TimeInterval?) {
        guard let realm = self.realm else { return }
        
        do {
            try realm.write {
                let newSong = Song(name: name, data: data, artist: artist, coverImageData: coverImageData, duration: duration)
                realm.add(newSong)
                print("Song successfully added.")
            }
        } catch {
            print("Error adding a song to the main array: \(error)")
        }
    }
    
    func addSongToPlaylist(song: Song, playlist: Playlist) {
        guard let realm = realm, !playlist.isInvalidated else { return }
        
        do {
            try realm.write {
                // Проверяем, существует ли уже такая песня в плейлисте
                if !playlist.songs.contains(where: { $0.id == song.id }) {
                    if let existingSong = realm.objects(Song.self).filter("name == %@", song.name).first {
                        playlist.songs.append(existingSong)
                    } else {
                        let newSong = Song(name: song.name, data: song.data, artist: song.artist, coverImageData: song.coverImageData, duration: song.duration)
                        realm.add(newSong)
                        playlist.songs.append(newSong)
                    }
                }
            }
        } catch {
            print("Error adding song to playlist: \(error)")
        }
    }
    
    func addSongToFavorites(_ song: Song) {
        guard let realm = self.realm else { return }
        
        do {
            try realm.write {
                let favoritePlaylist = realm.objects(Playlist.self).filter("name == 'Favorite'").first ?? {
                    let newPlaylist = Playlist(name: "Favorite")
                    realm.add(newPlaylist)
                    return newPlaylist
                }()
                
                /// Check if the song already exists in your favorites
                if !favoritePlaylist.songs.contains(where: { $0.id == song.id }) {
                    if let existingSong = realm.object(ofType: Song.self, forPrimaryKey: song.id) {
                        favoritePlaylist.songs.append(existingSong)
                    } else {
                        let newSong = Song(value: song)
                        realm.add(newSong)
                        favoritePlaylist.songs.append(newSong)
                    }
                    print("Song added to favorites successfully.")
                }
            }
        } catch {
            print("Error adding song to favorites: \(error)")
        }
    }
    
    func addPlaylist(_ playlist: Playlist) {
        if let realm = realm {
            do {
                try realm.write {
                    realm.add(playlist)
                }
            } catch {
                print("Error adding playlist to realm", error)
            }
        }
    }
    
    // MARK: - Update
    func updatePlaylistName(playlistId: ObjectId, newName: String) {
        do {
            guard let playlist = realm?.object(ofType: Playlist.self, forPrimaryKey: playlistId) else { return }
            try realm?.write {
                playlist.name = newName
            }
        } catch {
            print("Failed to update playlist name: \(error)")
        }
    }
    
    func updatePlaylistImage(playlistId: ObjectId, newImageData: Data) {
        do {
            guard let playlist = realm?.object(ofType: Playlist.self, forPrimaryKey: playlistId) else { return }
            try realm?.write {
                playlist.image = newImageData
            }
        } catch {
            print("Failed to update playlist image: \(error)")
        }
    }
    
    // MARK: - Delete
    func deleteSong(songId: ObjectId) {
        guard let realm = realm, let songToDelete = realm.object(ofType: Song.self, forPrimaryKey: songId) else { return }
        do {
            try realm.write {
                realm.delete(songToDelete)
            }
        } catch {
            print("Error deleting song: \(error)")
        }
    }
    
    func deleteSongs(withIDs ids: Set<ObjectId>) {
        guard let realm = realm else { return }
        
        do {
            let songsToDelete = ids.compactMap { realm.object(ofType: Song.self, forPrimaryKey: $0) }
            try realm.write {
                realm.delete(songsToDelete)
            }
        } catch {
            print("Error deleting songs: \(error.localizedDescription)")
        }
    }
    
    func deletePlaylists(withIDs ids: Set<ObjectId>) {
        guard let realm = realm else { return }
        
        do {
            let playlistsToDelete = ids.compactMap { realm.object(ofType: Playlist.self, forPrimaryKey: $0) }
            try realm.write {
                for playlist in playlistsToDelete {
                    // Пример удаления связанных песен, если это необходимо
                    // realm.delete(playlist.songs)
                    realm.delete(playlist)
                }
            }
        } catch {
            print("Error deleting playlists: \(error.localizedDescription)")
        }
    }
    
    func removeSongFromFavorite(songId: ObjectId) {
        guard let realm = realm, let favoritePlaylist = playlists?.filter("name == 'Favorite'").first else { return }
        
        if let song = favoritePlaylist.songs.filter("id == %@", songId).first {
            do {
                try realm.write {
                    if let index = favoritePlaylist.songs.index(of: song) {
                        favoritePlaylist.songs.remove(at: index)
                    }
                }
            } catch let error {
                print("Ошибка при удалении песни из плейлиста: \(error.localizedDescription)")
            }
        }
    }
        
    // MARK: - Group Data Base Realm
    func appGroupRealmConfiguration() -> Realm.Configuration {
        let appGroupIdentifier = "group.OMP"
        let sharedContainerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier)!
        let realmURL = sharedContainerURL.appendingPathComponent("SharedRealm.realm")
        return Realm.Configuration(fileURL: realmURL)
    }
}
