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
        
        UIElementSizes.navigationBarMaxY += navigationController!.navigationBar.frame.maxY
        
        setupView()
        
    }
    
    
    fileprivate func setupView() {
        
        self.title = self.searchTerm
        //searchView.searchHistoryTableView.dataSource = self
        //searchView.searchHistoryTableView.register(SearchTermCell.self, forCellReuseIdentifier: "search_term_cell")
        
        list = SearchResultsViewModel.results
        
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
        let url = URL(string: item.artworkUrl100)
        
        cell.albumTitleLabel.text = item.collectionName
        cell.artistTitleLabel.text = item.artistName
        cell.resultImageView.kf.setImage(with: url)
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
   
        
    }
    
}
