//
//  PlaylistModesViewController.swift
//  Lesson12HW
//

//

import UIKit


class PlaylistModesViewController: UIViewController {
    
    @IBOutlet weak var contentView: PlaylistModesView!
    
    var model: PlaylistModesModel!
    var songs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        loadData()
    }
    
    private func setupInitialState() {
        model = PlaylistModesModel()
        model.delegate = self
        contentView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
    
    private func loadData() {
        self.songs = loadPlaylistData()
        self.contentView.tableView.reloadData()
    }
    
    private func loadPlaylistData() -> [Song] {
        guard let url = Bundle.main.url(forResource: "playlist", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let playlist = try? JSONDecoder().decode(Playlist.self, from: data) else {
            return []
        }
        return playlist.songs
    }
}

extension PlaylistModesViewController: PlaylistModesViewDelegate {
    func selectedMode(mode: Int) {
        switch mode {
        case 0:
            print("All mode selected")
        case 1:
            print("By genre mode selected")
        case 2:
            print("By author mode selected")
        default:
            break
        }
    }
}

extension PlaylistModesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
        let song = songs[indexPath.row]
        cell.textLabel?.text = "\(song.author) - \(song.songTitle)"
        return cell
    }
}

extension PlaylistModesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension PlaylistModesViewController: PlaylistModesModelDelegate {
    func dataDidLoad() {
        
    }
    
    func dataDidLoad(songs: [Song]) {
        self.songs = songs
        contentView.tableView.reloadData()
    }
}
