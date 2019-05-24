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
        //searchView.searchHistoryTableView.dataSource = self
        //searchView.searchHistoryTableView.register(SearchTermCell.self, forCellReuseIdentifier: "search_term_cell")
        
        list = SearchAlbumResultsViewModel.results
        
        resultsView.resultsTableView.delegate = self
        resultsView.resultsTableView.dataSource = self
        resultsView.resultsTableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: "results_cell")
        
        view = resultsView
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.list[indexPath.row]
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
        
        if self.list.count == 0 {
            resultsView.resultsTableView.setEmptyMessage("No Results Found for \"\(searchTerm!)\"")
        } else {
            resultsView.resultsTableView.restore()
        }
        
        return self.list.count
    }
    
    @objc func handleAlbumTap(_ recognizer: UITapGestureRecognizer) {
  
        recognizer.view?.doGlowAnimation(withColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        let album = SearchAlbumResultsViewModel.results[recognizer.view!.tag]
        let collectionId = album.collectionId
        print("album clicked with colleciton id:",collectionId)
        
        NetworkManager.instance.getAlbumTracks(collectionId: collectionId) { (requestedTracks) in
            SearchSongsResultsViewModel.results = requestedTracks
            print(requestedTracks)
            DispatchQueue.main.async {
                
                let albumVC = AlbumController()
                albumVC.albumName = album.collectionName
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

extension UIView{
    enum GlowEffect:Float{
        case small = 0.4, normal = 1, big = 5
    }
    
    func doGlowAnimation(withColor color:UIColor, withEffect effect:GlowEffect = .normal) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowRadius = 0
        layer.shadowOpacity = effect.rawValue
        layer.shadowOffset = .zero
        
        let glowAnimation = CABasicAnimation(keyPath: "shadowRadius")
        glowAnimation.fromValue = 0
        glowAnimation.toValue = 1
        glowAnimation.beginTime = CACurrentMediaTime()+0.3
        glowAnimation.duration = CFTimeInterval(0.3)
        glowAnimation.fillMode = CAMediaTimingFillMode.removed
        glowAnimation.autoreverses = true
        glowAnimation.isRemovedOnCompletion = true
        layer.add(glowAnimation, forKey: "shadowGlowingAnimation")
    }
}
