//
//  PlaylistByGenreViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistByGenreViewController: UIViewController {
    
    @IBOutlet weak var contentView: PlaylistByGenreView!
   
    
    var model: PlaylistByGenreModel!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupInitialState()
            loadData()
        }
        
        private func setupInitialState() {
            model = PlaylistByGenreModel()
            model.delegate = self
            contentView.tableView.dataSource = self
            contentView.tableView.delegate = self
            contentView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SongCell")
        }
        
        private func loadData() {
            model.loadData()
        }
    }

    extension PlaylistByGenreViewController: PlaylistByGenreModelDelegate {
        func dataDidLoad() {
            DispatchQueue.main.async {
                self.contentView.tableView.reloadData()
            }
        }
    }

    extension PlaylistByGenreViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return model.songsByGenre.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let genre = model.songsByGenre.keys.sorted()[section]
            return model.songsByGenre[genre]?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
            let genre = model.songsByGenre.keys.sorted()[indexPath.section]
            if let songs = model.songsByGenre[genre] {
                let song = songs[indexPath.row]
                cell.textLabel?.text = "\(song.songTitle) - \(song.author)"
            }
            return cell
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return model.songsByGenre.keys.sorted()[section]
        }
    }

    extension PlaylistByGenreViewController: UITableViewDelegate {
       
    }

