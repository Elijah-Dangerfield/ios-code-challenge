//
//  ResultsController.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by eli dangerfield on 5/23/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import Foundation
import UIKit

class AlbumController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate  {
    
    lazy var resultsView: ResultsView = { return ResultsView() }()
    var list = [ResultsViewModel]()
    var searchTerm: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIElementSizes.navigationBarMaxY += navigationController!.navigationBar.frame.maxY
        
        setupView()
        
    }
    
    
    fileprivate func setupView() {
        
        self.title = self.searchTerm
        //searchView.searchHistoryTableView.dataSource = self
        //searchView.searchHistoryTableView.register(SearchTermCell.self, forCellReuseIdentifier: "search_term_cell")
        
        let result = ResultsViewModel(artistTitle: "artist Title", albumTitle: "album title", songTitle: "Song title", albumImage: UIImage(named:"grapefruit-slice-332-332")!)
        
        for _ in 0...10{
            list.append(result)
        }
        
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

        cell.albumTitleLabel.text = item.albumTitle
        cell.artistTitleLabel.text = item.artistTitle
        cell.songTitleLabel.text = item.songTitle
        cell.resultImageView.image = item.albumImage
        
        return cell
    }
    
}
