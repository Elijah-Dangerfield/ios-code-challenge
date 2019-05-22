//
//  SearchViewController.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by eli dangerfield on 5/22/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

    lazy var searchView: SearchView = { return SearchView() }()
    
    var currentUser: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIElementSizes.navigationBarMaxY += navigationController!.navigationBar.frame.maxY

        setupView()

    }
    
    
    fileprivate func setupView() {
        
        self.title = UserAccounts.userAccountEmail[currentUser!]
        self.navigationItem.leftBarButtonItem = searchView.backButton
        searchView.backButton.target = self
        searchView.backButton.action = #selector(handleBackButtonTap)

        
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
    }
    
    
    @objc func handleBackButtonTap() {
        print("Back pressed")
        currentUser = nil
        self.navigationController?.popToRootViewController(animated: true)
    }
}
