//
//  ResultsController.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by eli dangerfield on 5/23/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import Foundation
import UIKit

class ResultsController: UIViewController, UITextFieldDelegate, UITableViewDataSource  {
    
    lazy var searchView: SearchView = { return SearchView() }()
    
    var searchTerm: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIElementSizes.navigationBarMaxY += navigationController!.navigationBar.frame.maxY
        
        setupView()
        
    }
    
    
    fileprivate func setupView() {
        
        self.title = self.searchTerm
        self.navigationItem.leftBarButtonItem = searchView.backButton
        //searchView.backButton.target = self
        
        //searchView.searchHistoryTableView.dataSource = self
        //searchView.searchHistoryTableView.register(SearchTermCell.self, forCellReuseIdentifier: "search_term_cell")
        
        
        
        searchView.searchTextField.delegate = self
    
        view = searchView
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchHistoryViewModel.searchedTerms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let termItem = SearchHistoryViewModel.searchedTerms[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "search_term_cell", for: indexPath) as! SearchTermCell

        cell.searchTermLable.text = termItem.searchTerm
        cell.timeStampLable.text = termItem.timeStamp

        return cell
    }
    
}
