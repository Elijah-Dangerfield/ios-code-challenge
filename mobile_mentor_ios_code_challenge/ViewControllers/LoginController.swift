//
//  LoginController.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by Jeremy Barger on 2/12/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    lazy var mainView: MainView = { return MainView() }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIElementSizes.navigationBarMaxY = navigationController!.navigationBar.frame.maxY
        
        setupUserAccounts()
    
        setupView()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainView.passwordTextField.text = ""
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func setupUserAccounts() {
        
        let defaultUsers = ["eli","jane.smith@email.com", "john.doe@email.com"]
        let defaultUserPasswords = ["eli","test1234%^&*", "*&^%4321tset"]
        
        var userCount = 0
        
        repeat {
            UserAccountViewModel.userEmail = defaultUsers[userCount]
            UserAccountViewModel.userPassword = defaultUserPasswords[userCount]
            UserAccountViewModel.setUserDict()
            userCount += 1
        } while userCount < defaultUsers.count
        
    }
    
    fileprivate func setupView() {
        
        mainView.emailTextField.delegate = self
        mainView.passwordTextField.delegate = self
        mainView.passwordTextField.isSecureTextEntry = true
        
        mainView.loginButton.addTarget(self, action: #selector(handleLoginButtonTap(sender:)), for: .touchUpInside)
        
        let dismissKeyboardTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissKeyboardTapGestureRecognizer.cancelsTouchesInView = false
        mainView.addGestureRecognizer(dismissKeyboardTapGestureRecognizer)
        view = mainView
        
    }
    
    @objc fileprivate func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func handleLoginButtonTap(sender: UIButton) {
        print("login pressed")
        guard let emailAddress = mainView.emailTextField.text?.lowercased() else { return }
            //not lowercased as passwords should be case sensitive for security
        guard let password = mainView.passwordTextField.text else { return }
        
    
        if let savedPassword = UserAccounts.users[emailAddress]{
            UserAccountViewModel.userEmail = emailAddress
            comparePassword(password: password, savedPassword: savedPassword)
        } else {
            let alertController = CreateAlertController().withNoActions(title: "User Account Not Found", message: "The user account that you are attempting to use does not exist.")
            alertController.addAction(UIAlertAction(title: "Canel", style: .cancel, handler: {(action: UIAlertAction!) in
                self.mainView.emailTextField.text = ""
                self.mainView.emailTextField.becomeFirstResponder()
            }))
            alertController.addAction(UIAlertAction(title: "Create Account", style: .default, handler: {(action: UIAlertAction!) in
                print("User is acreating a new account")
                let createAccountVC = CreateAccountController()
                createAccountVC.emailAddress = self.mainView.emailTextField.text
                self.navigationController?.pushViewController(createAccountVC, animated: true)
            }))
            present(alertController, animated: true) {
                self.mainView.passwordTextField.text = ""
            }
        }
    }
    
    
    fileprivate func comparePassword(password: String, savedPassword: String) {
        if password == savedPassword {
            print("User Login Successful. Navigate to SearchController")
            let searchVC = SearchViewController()
            searchVC.currentUser = self.mainView.emailTextField.text?.lowercased()
            self.navigationController?.pushViewController(searchVC, animated: true)

        } else {
            let alertController = CreateAlertController().withCancelAction(title: "Incorrect Password", message: "Please re-enter your password and try again.")
            
            present(alertController, animated: true) {
                self.mainView.passwordTextField.text = ""
                self.mainView.passwordTextField.becomeFirstResponder()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    
}
