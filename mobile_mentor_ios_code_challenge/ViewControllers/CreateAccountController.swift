//
//  CreateAccountController.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by eli dangerfield on 5/24/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import UIKit

class CreateAccountController: UIViewController {
    
    lazy var createAccountView: CreateAccountView = { return CreateAccountView() }()
    var emailAddress: String?
    
    enum CreateAccountError: Error {
        case incompleteForm
        case invalidEmail
        case passwordMatching
        case incorrectPasswordLength
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        createAccountView.emailTextField.text = self.emailAddress ?? "*email*"
        createAccountView.passwordTextField.text = ""
        createAccountView.confirmPasswordTextField.text = ""

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func setupView() {
        
        self.title = "Create Account"
        
        createAccountView.createAccountButton.addTarget(self, action: #selector(handleCreateAccountTap(sender:)), for: .touchUpInside)
        createAccountView.emailTextField.text = self.emailAddress ?? "*email*"

        let dismissKeyboardTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissKeyboardTapGestureRecognizer.cancelsTouchesInView = false
        createAccountView.addGestureRecognizer(dismissKeyboardTapGestureRecognizer)
        view = createAccountView
        
    }
    
    @objc fileprivate func handleCreateAccountTap(sender: UIButton)  {
        print("User pressed create account button")
        
        do {
            try createAccount()
            
        } catch CreateAccountError.incompleteForm {
            CreateAlertController.showBasic(self,title: "Incomplete Form", message: "Please fill out email and both elipassword fields")
        } catch CreateAccountError.invalidEmail {
            CreateAlertController.showBasic(self,title: "Invalid Email Format", message: "Please make sure you format your email correctly")
        } catch CreateAccountError.incorrectPasswordLength {
            CreateAlertController.showBasic(self,title: "Password Too Short", message: "Password should be at least 6 characters")
        } catch CreateAccountError.passwordMatching {
            CreateAlertController.showBasic(self,title: "Passwords don't match", message: "Please confirm that both passwords match")
        } catch {
            CreateAlertController.showBasic(self,title: "Unable To Login", message: "There was an error when attempting to login")
        }
        
    }
    
    
    @objc fileprivate func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func createAccount() throws{
        let email = self.createAccountView.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = self.createAccountView.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirmPassword = self.createAccountView.confirmPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            throw CreateAccountError.incompleteForm
        }
        
        if !email.isValidEmail {
            throw CreateAccountError.invalidEmail
        }
        
        if password.count < 6 {
            throw CreateAccountError.incorrectPasswordLength
        }
        
        if password != confirmPassword {
            throw CreateAccountError.passwordMatching
        }
        
        print("creating account")
        
        UserAccountViewModel.userEmail = email
        UserAccountViewModel.userPassword = password
        UserAccountViewModel.setUserDict()
        
        print("Account Created, for user ",email)
        
        let searchVC = SearchViewController()
        searchVC.currentUser = email
        self.navigationController?.pushViewController(searchVC, animated: true)

    }
    
    
    
}
