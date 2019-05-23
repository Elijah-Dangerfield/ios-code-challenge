//
//  SearchViewController.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by eli dangerfield on 5/22/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate  {

    lazy var searchView: SearchView = { return SearchView() }()
    
    var currentUser: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIElementSizes.navigationBarMaxY += navigationController!.navigationBar.frame.maxY

        setupView()

    }
    
    
    fileprivate func setupView() {
        let headerView = SearchHistoryHeaderCell()
        
        self.title = UserAccounts.userAccountEmail[currentUser!]
        self.navigationItem.leftBarButtonItem = searchView.backButton
        searchView.backButton.target = self
        searchView.backButton.action = #selector(handleBackButtonTap)
        
        searchView.searchHistoryTableView.dataSource = self
        searchView.searchHistoryTableView.delegate = self
        searchView.searchHistoryTableView.register(SearchTermCell.self, forCellReuseIdentifier: "search_term_cell")
        
    
        searchView.searchHistoryTableView.tableHeaderView = headerView
        headerView.clearButton.addTarget(self, action: #selector(handleClearButtonTap), for: .touchUpInside)
        

        searchView.searchTextField.delegate = self
        searchView.searchButton.addTarget(self, action: #selector(handleSearchButtonTap(sender:)), for: .touchUpInside)

        let dismissKeyboardTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissKeyboardTapGestureRecognizer.cancelsTouchesInView = false
        searchView.addGestureRecognizer(dismissKeyboardTapGestureRecognizer)
        view = searchView
        
    }
    
    @objc fileprivate func dismissKeyboard() {
        view.endEditing(true)
    }
    
     @objc func handleClearButtonTap() {
        print("Clear Button Tapped")
        SearchHistoryViewModel.searchedTerms = [SearchTermViewModel]()
        searchView.searchHistoryTableView.reloadData()
        searchView.searchHistoryTableView.isHidden = true
    }
    
    @objc func handleSearchButtonTap(sender: UIButton) {
        print("search pressed, handle this")
        
        guard let searchTerm = self.searchView.searchTextField.text, !searchTerm.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else{
            let alertController = CreateAlertController().withCancelAction(title: "Invalid Search", message: "Please enter a valid search term and try again.")
        
            present(alertController, animated: true) {
                self.searchView.searchTextField.text = ""
                self.searchView.searchTextField.becomeFirstResponder()
            }
            return
        }
        
        //passed validation, use seach term
        self.searchView.searchTextField.text = ""
        let timeStamp = getTimeStamp()
        let term = SearchTermViewModel(searchTerm: searchTerm, timeStamp: timeStamp.description)
        SearchHistoryViewModel.searchedTerms.append(term)
        searchView.searchHistoryTableView.reloadData()
        searchView.searchHistoryTableView.isHidden = false
        
    }
    
    func getTimeStamp() -> String{
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "MM-dd-yyy HH:mm:ss"
        
        return formatter.string(from: now)
    }
    @objc func handleBackButtonTap() {
        print("Back pressed")
        currentUser = nil
        self.navigationController?.popToRootViewController(animated: true)
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
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let search = SearchHistoryViewModel.searchedTerms[indexPath.row].searchTerm
        print("searching for \(search)")

        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem //
        
        let resultsVC = AlbumController()
        resultsVC.searchTerm = search
        self.navigationController?.pushViewController(resultsVC, animated: true)

    }
    
}


