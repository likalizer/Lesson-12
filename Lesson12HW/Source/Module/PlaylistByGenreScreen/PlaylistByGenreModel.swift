//
//  PlaylistByGenreModel.swift
//  Lesson12HW
//

//

import Foundation


protocol PlaylistByGenreModelDelegate: AnyObject {
    func dataDidLoad()
}

class PlaylistByGenreModel {
    weak var delegate: PlaylistByGenreModelDelegate?
    private let dataLoader = DataLoaderService()
    
    var songsByGenre: [String: [Song]] = [:] 
    
    func loadData() {
        dataLoader.loadPlaylist { [weak self] playlist in
            guard let playlist = playlist else { return }
            
            var groupedSongs: [String: [Song]] = [:]
            for song in playlist.songs {
                if var songs = groupedSongs[song.genre] {
                    songs.append(song)
                    groupedSongs[song.genre] = songs
                } else {
                    groupedSongs[song.genre] = [song]
                }
            }
            
            self?.songsByGenre = groupedSongs
            
            DispatchQueue.main.async {
                self?.delegate?.dataDidLoad()
            }
        }
    }
}
