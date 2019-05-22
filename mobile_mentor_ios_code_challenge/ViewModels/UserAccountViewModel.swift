//
//  UserAccountViewModel.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by Jeremy Barger on 2/13/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import Foundation

struct UserAccountViewModel {
    
    static var userEmail: String?
    
    static var userPassword: String?
    
    func setUserDict() {
        //creates a user with a user ID corresponding to their position in the userAccountEmail
        let userID = UserAccounts.userAccountEmail.count > 0 ? UserAccounts.userAccountEmail.count : 0
        
        UserAccounts.userAccountEmail[userID] = UserAccountViewModel.userEmail?.lowercased()
        UserAccounts.userPasswords[userID] = UserAccountViewModel.userPassword?.lowercased()
        
        ///so if i wanted to add someone to this, I would make an instnace of useracount view model, set the username
        // and password, and call set user dict,which places them in the dictionary
    }
    
    func getUserID(forEmailAddress email: String) -> Int {
        var userID: Int = 0
        
        for user in UserAccounts.userAccountEmail {
            if user.value == email {
                userID = user.key
            }
        }
        return userID
    }
    
}
