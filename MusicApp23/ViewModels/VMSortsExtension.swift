//
//  VMSortsExtension.swift
//  MusicApp23
//
//  Created by Dima on 25.01.2024.
//

import Foundation

// MARK: - Sort`s Methods
extension ViewModel {
    
    /// Add Last 10 Songs To RecentlyImported Playlist
    func recentlyImportedUpdate() {
        recentlyImported = Array(allSongs.suffix(10)).reversed()
    }
    
    /// Sorting Songs By Artist
    func sortSongsByArtist() {
        allSongs = allSongs.sorted { (song1, song2) in
            return song1.artist?.localizedCaseInsensitiveCompare(song2.artist ?? "") == .orderedAscending
        }
    }
    
    /// Sorting Songs By Title
    func sortSongsByTitle() {
        allSongs = allSongs.sorted { (song1, song2) in
            return song1.name.localizedCaseInsensitiveCompare(song2.name) == .orderedAscending
        }
    }
    
    /// Sorting Songs By Duration
    func sortSongsByDuration() {
        allSongs = allSongs.sorted { (song1, song2) in
            guard let duration1 = song1.duration, let duration2 = song2.duration else {
                return false
            }
            return duration1 < duration2
        }
    }
    
    /// Sorting Songs By Day
    func sortSongsByDate() {
        allSongs = originalSongsOrder.reversed()
    }
    
    /// Methods For Counting Playlist Listens
    func playlistListens(playlist: PlaylistModel) {
        
        if let index = allPlaylists.firstIndex(where: { $0.id == playlist.id }) {
            allPlaylists[index].numberOfListens += 1
        }
        updatePopularPlaylists()
    }
    
    func updatePopularPlaylists() {
        let sortedPlaylists = allPlaylists.sorted { $0.numberOfListens > $1.numberOfListens }
        popularPlaylists = Array(sortedPlaylists.prefix(10))
    }
}
