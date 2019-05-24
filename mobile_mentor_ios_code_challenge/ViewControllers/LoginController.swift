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
    
    enum LoginError: Error {
        case incompleteForm
        case invalidEmail
        case incorrectEmail
        case incorrectPassword
        case incorrectPasswordLength
    }
    

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
        print("User pressed login button")
        
        do {
            try login()
            
        } catch LoginError.incompleteForm {
            CreateAlertController.showBasic(self,title: "Incomplete Form", message: "Please fill out email and both elipassword fields")
        } catch LoginError.invalidEmail {
            CreateAlertController.showBasic(self,title: "Invalid Email Format", message: "Please make sure you format your email correctly")
        } catch LoginError.incorrectPasswordLength {
            CreateAlertController.showBasic(self,title: "Password Too Short", message: "Password should be at least 6 characters")
        } catch LoginError.incorrectPassword {
            CreateAlertController.showBasic(self,title: "Incorrect Password", message: "Password does not match account")
        } catch LoginError.incorrectEmail {
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
        } catch {
            CreateAlertController.showBasic(self,title: "Unable To Login", message: "There was an error when attempting to login")
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func login() throws{
        print("login pressed")
        guard let emailAddress = mainView.emailTextField.text?.lowercased() else { return }
        //not lowercased as passwords should be case sensitive for security
        guard let password = mainView.passwordTextField.text else { return }
        
        if emailAddress.isEmpty || password.isEmpty  {
            throw LoginError.incompleteForm
        }
        
        if !emailAddress.isValidEmail {
            throw LoginError.invalidEmail
        }
        
        if password.count < 6 {
            throw LoginError.incorrectPasswordLength
        }
        
        guard let savedPassword = UserAccounts.users[emailAddress] else{
            throw LoginError.incorrectEmail
        }
        
        if(password != savedPassword){
            throw LoginError.incorrectPassword
        }
        
        
        print("User found, login in ",emailAddress)
        let searchVC = SearchViewController()
        searchVC.currentUser = self.mainView.emailTextField.text?.lowercased()
        self.navigationController?.pushViewController(searchVC, animated: true)
        
    }

}
