//
//  ResultsController.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by eli dangerfield on 5/23/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ResultsController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate  {
    
    lazy var resultsView: ResultsView = { return ResultsView() }()
    var list = [Album]()
    var searchTerm: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupView()
        
    }

    fileprivate func setupView() {
        
        self.title = self.searchTerm
  
        resultsView.resultsTableView.delegate = self
        resultsView.resultsTableView.dataSource = self
        resultsView.resultsTableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: "results_cell")
        
        view = resultsView
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchAlbumResultsModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = SearchAlbumResultsModel.results[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "results_cell", for: indexPath) as! ResultsTableViewCell
        cell.selectionStyle = .none
        let url = URL(string: item.artworkUrl100)
        
        cell.albumTitleLabel.text = item.collectionName
        cell.artistTitleLabel.text = item.artistName
        cell.resultImageView.kf.setImage(with: url)
        
        cell.artistTitleLabel.tag = indexPath.row
        cell.artistTitleLabel.isUserInteractionEnabled = true
        cell.artistTitleLabel.addGestureRecognizer(getGestureRecognizer())

        cell.resultImageView.tag = indexPath.row
        cell.resultImageView.isUserInteractionEnabled = true
        cell.resultImageView.addGestureRecognizer(getGestureRecognizer())
        
        cell.albumTitleLabel.tag = indexPath.row
        cell.albumTitleLabel.isUserInteractionEnabled = true
        cell.albumTitleLabel.addGestureRecognizer(getGestureRecognizer())

        return cell
    }
    
    func getGestureRecognizer() -> UIGestureRecognizer{
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleAlbumTap(_:)))
        tap.numberOfTapsRequired = 1
        return tap
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if SearchAlbumResultsModel.results.count == 0 {
            resultsView.resultsTableView.setEmptyMessage("No Results Found for \"\(searchTerm!)\"")
        } else {
            resultsView.resultsTableView.restore()
        }
        
        return SearchAlbumResultsModel.results.count
    }
    
    @objc func handleAlbumTap(_ recognizer: UITapGestureRecognizer) {
  
        let album = SearchAlbumResultsModel.results[recognizer.view!.tag]
        let collectionId = album.collectionId
        let url = album.artworkUrl100
        
        print("album clicked with colleciton id:",collectionId)
        
        NetworkManager.instance.getAlbumTracks(collectionId: collectionId) { (requestedTracks) in
            SearchSongsResultsModel.results = requestedTracks
            DispatchQueue.main.async {
                let albumVC = AlbumController()
                albumVC.albumName = album.collectionName
                albumVC.artistName = album.artistName
                albumVC.releaseDate = album.releaseDate
                albumVC.genre = album.primaryGenreName
                albumVC.albumImageUrl = URL(string: url)
                self.navigationController?.pushViewController(albumVC, animated: true)
            }
        }
    }
    
        
}

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
