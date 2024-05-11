//
//  MainPlaylistViewController.swift
//  Lesson12HW
//

//

import UIKit

class MainPlaylistViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var contentView: MainPlaylistView!
    var model: MainPlaylistModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = MainPlaylistModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
}

extension MainPlaylistViewController: MainPlaylistModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

extension MainPlaylistViewController: MainPlaylistViewDelegate {
    
}

extension MainPlaylistViewController: UITableViewDataSource {
    
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return model.items.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell") 
            else {
                return UITableViewCell(style: .subtitle, reuseIdentifier: "MainPlaylistCell")
            }
            
            let song = model.items[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = """
                    Автор: \(song.author)
                    Назва пісні: \(song.songTitle)
                    Альбом: \(song.albumTitle)
                    Жанр: \(song.genre)
                    """
            return cell
        }
    }

