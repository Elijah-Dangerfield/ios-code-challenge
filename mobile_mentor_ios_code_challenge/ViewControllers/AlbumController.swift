//
//  AlbumController.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by eli dangerfield on 5/23/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class AlbumController: UIViewController, UITextFieldDelegate {
    
    
    var albumName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupView()
        
    }
    
    
    fileprivate func setupView() {
        
        self.title = self.albumName
        
    }
    
    
}


