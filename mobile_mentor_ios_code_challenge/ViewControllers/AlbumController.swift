//
//  AlbumController.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by eli dangerfield on 5/23/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class AlbumController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    lazy var albumView: AlbumView = { return AlbumView() }()
    var albumName: String?
    var albumImageUrl: URL?
    var artistName: String?
    var genre: String?
    var releaseDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupView()
        
    }
    
    fileprivate func setupView() {
        
        self.title = self.albumName
        
        albumView.songResultsTableView.dataSource = self
        albumView.songResultsTableView.delegate = self
        albumView.songResultsTableView.register(SongsTableViewCell.self, forCellReuseIdentifier: "song_cell")
        
        albumView.albumArtImageView.kf.setImage(with: albumImageUrl)
        albumView.albumTitleLabel.text = self.albumName
        albumView.artistNameLabel.text = self.artistName
        albumView.genreYearLabel.text = "\(self.genre!)・\(self.releaseDate!)"

        
        self.view = albumView
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchSongsResultsModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = SearchSongsResultsModel.results[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "song_cell", for: indexPath) as! SongsTableViewCell
        cell.selectionStyle = .none
        cell.songTitleLabel.text = song.songName
        cell.songNumberLabel.text = String(song.songNumber)
        
        return cell
    }
    
    
}


