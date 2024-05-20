//
//  PlaylistMoveDeleteModel.swift
//  Lesson12HW
//

//

import Foundation

protocol PlaylistMoveDeleteModelDelegate: AnyObject {
    func dataDidLoad()
}

class PlaylistMoveDeleteModel {
    weak var delegate: PlaylistMoveDeleteModelDelegate?
    var items: [Song] = []
    
    func loadData() {
        guard let url = Bundle.main.url(forResource: "Playlist", withExtension: "json") else {
            assertionFailure("Missing file: Playlist.json")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let playlist = try JSONDecoder().decode(Playlist.self, from: data)
            self.items = playlist.songs
            DispatchQueue.main.async {
                self.delegate?.dataDidLoad()
            }
        } catch {
            debugPrint("error:\(error)")
        }
    }
}

