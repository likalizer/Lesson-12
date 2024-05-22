//
//  PlaylistModesView.swift
//  Lesson12HW
//
//  Created by Лика Котик on 22.05.2024.
//

import UIKit

protocol PlaylistModesViewDelegate: AnyObject {
    func selectedMode(mode: Int)
}


class PlaylistModesView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    

        @IBOutlet weak var segmentControl: UISegmentedControl!
        
        weak var delegate: PlaylistModesViewDelegate?
        
        override func awakeFromNib() {
            super.awakeFromNib()
            setupSegmentedControl()
        }
        
         func setupSegmentedControl() {
            segmentControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        }
        
        @objc private func segmentValueChanged(_ sender: UISegmentedControl) {
            delegate?.selectedMode(mode: sender.selectedSegmentIndex)
        }
    }

