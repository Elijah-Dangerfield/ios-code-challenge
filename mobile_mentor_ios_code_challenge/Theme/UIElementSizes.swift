//
//  UIElementSizes.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by Jeremy Barger on 2/12/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import UIKit

struct UIElementSizes {
    
    static var windowWidth: CGFloat = UIScreen.main.bounds.width
    static var windowHeight: CGFloat = UIScreen.main.bounds.height
    static var navigationBarMaxY: CGFloat = 0
    
    static var labelWidth: CGFloat = UIScreen.main.bounds.width - 50
    
    static var cellLabelMaxWidth: CGFloat = UIScreen.main.bounds.width/2
    static var tableViewRowHeight_small: CGFloat = 50
    static var tableViewRowHeight_large: CGFloat = 150
    static var cellLabelHeight: CGFloat = 30
    static var textFieldWidth: CGFloat = UIScreen.main.bounds.width - 50

    static var singleLineTextFieldHeight: CGFloat = 50
    static var multilineTextFieldHeight: CGFloat = 200
    
    static var segmentedControlWidth: CGFloat = UIScreen.main.bounds.width - 50
    static var segmentedControlHeight: CGFloat = 50
    
    static var buttonWidth: CGFloat = UIScreen.main.bounds.width / 2
    static var buttonHeight: CGFloat = 50
    
}
