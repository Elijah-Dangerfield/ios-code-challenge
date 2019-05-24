//
//  UserAccountViewModel.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by Jeremy Barger on 2/13/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import Foundation

struct UserAccountViewModel {
    
    static var userEmail: String = ""
    
    static var userPassword: String = ""
    
    
    static func setUserDict() {
        //creates a user with a user ID corresponding to their position in the userAccountEmail
        UserAccounts.users[UserAccountViewModel.userEmail.lowercased()] = UserAccountViewModel.userPassword
        UserAccountViewModel.resetUser()
        
    }
    
    static func resetUser(){
        UserAccountViewModel.userEmail = ""
        UserAccountViewModel.userPassword = ""
    }
    
    
}
