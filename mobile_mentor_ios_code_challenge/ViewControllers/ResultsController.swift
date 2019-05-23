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
        cell.selectionStyle = .none
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if self.list.count == 0 {
            resultsView.resultsTableView.setEmptyMessage("No Results Found for \"\(searchTerm!)\"")
        } else {
            resultsView.resultsTableView.restore()
        }
        
        return self.list.count
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
