//
//  SearchHistoryHeaderCell.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by eli dangerfield on 5/23/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import UIKit

class SearchHistoryHeaderCell: UIView {
    
    var titleLabel: UILabel = {
        let textField = UILabel()
        textField.textAlignment = .center
        textField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textField.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        textField.layer.masksToBounds = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "Search History"
        return textField
    }()
    
    var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        button.setTitleColor(UIColor().HexToColor(hexString: "#50A3E3", alpha: 1), for: .normal)
        button.backgroundColor = UIColor().HexToColor(hexString: "##1ecc35", alpha: 0)
        button.layer.borderWidth = 0
        button.layer.borderColor = UIColor().HexToColor(hexString: "##1ecc35", alpha: 1).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
   
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 1, y: 50, width: UIScreen.main.bounds.width, height: 30))
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    fileprivate func setupView() {
        
        backgroundColor = #colorLiteral(red: 0.7990349531, green: 0.2438177466, blue: 0.2458363473, alpha: 1)
        
        self.addSubview(titleLabel)
        self.addSubview(clearButton)

        setConstraints()
    }
    
    fileprivate func setConstraints() {
        
        Constraints().constraintWithCenterYAndCenterXAnchor(field: titleLabel, width: UIElementSizes.windowWidth/3, height: UIElementSizes.cellLabelHeight, centerYAnchor: centerYAnchor, centerYConstant: 0, centerXAnchor: centerXAnchor, centerXConstant: 0)
        
        Constraints().constraintWithCenterYAnchorAndTrailing(field: clearButton, width: 50, height: 50, centerYAnchor: centerYAnchor, centerYConstant: 0, trailingAnchor: trailingAnchor, trailingConstant: -12)
    }
    
}
