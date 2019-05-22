//
//  SearchTermCell.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by eli dangerfield on 5/22/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import UIKit

class SeachTermCell: UIView {
    
    var searchTermLable: UILabel = {
        let textField = UILabel()
        textField.backgroundColor = UIColor().HexToColor(hexString: "#0463AC", alpha: 1)
        textField.layer.borderColor = UIColor().HexToColor(hexString: "#2590E3", alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 25
        textField.textAlignment = .center
        textField.textColor = UIColor().HexToColor(hexString: "#FFFFFF", alpha: 1)
        textField.font = UIFont(name: "AvenirNext-Regular", size: 20)
        textField.layer.shadowColor = UIColor().HexToColor(hexString: "#000000", alpha: 1).cgColor
        textField.layer.shadowRadius = 5
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowOpacity = 1
        textField.layer.masksToBounds = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    var timeStampLable: UILabel = {
        let textField = UILabel()
        textField.backgroundColor = UIColor().HexToColor(hexString: "#0463AC", alpha: 1)
        textField.layer.borderColor = UIColor().HexToColor(hexString: "#2590E3", alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 25
        textField.textAlignment = .center
        textField.textColor = UIColor().HexToColor(hexString: "#FFFFFF", alpha: 1)
        textField.font = UIFont(name: "AvenirNext-Regular", size: 20)
        textField.layer.shadowColor = UIColor().HexToColor(hexString: "#000000", alpha: 1).cgColor
        textField.layer.shadowRadius = 5
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowOpacity = 1
        textField.layer.masksToBounds = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
        
    }
    
    fileprivate func setupView() {
        
        backgroundColor = UIColor().HexToColor(hexString: "#323F44", alpha: 1)
        
        self.addSubview(timeStampLable)
        self.addSubview(searchTermLable)
        
        setConstraints()
        
    }
    
    
    
    fileprivate func setConstraints() {
        
        Constraints().constraintWithTopAndCenterXAnchor(field: searchTermLable, width: UIElementSizes.textFieldWidth, height: 50, topAnchor: topAnchor, topConstant: 0, centerXAnchor: centerXAnchor, centerXConstant: 0)
    }
    
}
