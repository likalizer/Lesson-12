//
//  PlaylistModesModel.swift
//  Lesson12HW
//

//
import Foundation

import Foundation

protocol PlaylistModesModelDelegate: AnyObject {
    func dataDidLoad()
}

class PlaylistModesModel {
    weak var delegate: PlaylistModesModelDelegate?
    private let dataLoader = DataLoaderService()
    
    var songs: [Song] = []
    
    func loadData() {
        dataLoader.loadPlaylist { [weak self] playlist in
            guard let self = self else { return }
            self.songs = playlist?.songs ?? []
            self.delegate?.dataDidLoad()
        }
    }
}
