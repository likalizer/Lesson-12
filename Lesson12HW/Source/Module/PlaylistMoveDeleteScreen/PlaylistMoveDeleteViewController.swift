//
//  PlaylistMoveDeleteViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistMoveDeleteViewController: UIViewController, PlaylistMoveDeleteModelDelegate, PlaylistMoveDeleteViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var contentView: PlaylistMoveDeleteView!
    var model: PlaylistMoveDeleteModel!
   
    override func viewDidLoad() {
            super.viewDidLoad()
            setupInitialState()
            model.loadData()
        }
        
        private func setupInitialState() {
            model = PlaylistMoveDeleteModel()
            model.delegate = self
            
            contentView.delegate = self
            
            contentView.tableView.dataSource = self
            contentView.tableView.delegate = self
            contentView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MainPlaylistCell")
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
        }
        
        @objc private func toggleEditMode() {
            let isEditing = !contentView.tableView.isEditing
            contentView.tableView.setEditing(isEditing, animated: true)
            navigationItem.rightBarButtonItem?.title = isEditing ? "Done" : "Edit"
        }
        
        // MARK: - PlaylistMoveDeleteModelDelegate
        
        func dataDidLoad() {
            DispatchQueue.main.async {
                self.contentView.tableView.reloadData()
            }
        }
        
        // MARK: - UITableViewDataSource
        
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return model.items.count
        }
        
    @objc(tableView:cellForRowAtIndexPath:) internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell", for: indexPath)
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
        
        // MARK: - UITableViewDelegate
        
    @objc(tableView:commitEditingStyle:forRowAtIndexPath:) func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                model.items.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        
    @objc(tableView:moveRowAtIndexPath:toIndexPath:) func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            let movedSong = model.items.remove(at: sourceIndexPath.row)
            model.items.insert(movedSong, at: destinationIndexPath.row)
        }
    }

