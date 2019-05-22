//
//  SearchView.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by eli dangerfield on 5/22/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    var searchTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "*enter artist/song name*", attributes: [NSAttributedString.Key.foregroundColor: UIColor().HexToColor(hexString: "#FFFFFF", alpha: 0.5)])
        textField.backgroundColor = UIColor().HexToColor(hexString: "#0463AC", alpha: 1)
        textField.layer.borderColor = UIColor().HexToColor(hexString: "#2590E3", alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 25
        textField.borderStyle = .line
        textField.keyboardType = .emailAddress
        textField.contentVerticalAlignment = .center
        textField.textAlignment = .center
        textField.textColor = UIColor().HexToColor(hexString: "#FFFFFF", alpha: 1)
        textField.font = UIFont(name: "AvenirNext-Regular", size: 20)
        textField.returnKeyType = .done
        textField.borderStyle = .none
        textField.layer.shadowColor = UIColor().HexToColor(hexString: "#000000", alpha: 1).cgColor
        textField.layer.shadowRadius = 5
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowOpacity = 1
        textField.layer.masksToBounds = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    var backButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: nil)
        barButtonItem.tintColor = #colorLiteral(red: 0.6700769067, green: 0.6863073707, blue: 0.6904536486, alpha: 1)
        return barButtonItem
    }()
    
    var seachHistoryTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .lightGray
        return tv
    }()

    
    
    var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 25)
        button.setTitleColor(UIColor().HexToColor(hexString: "#50A3E3", alpha: 1), for: .normal)
        button.backgroundColor = UIColor().HexToColor(hexString: "##1ecc35", alpha: 0)
        button.layer.borderWidth = 0
        button.layer.borderColor = UIColor().HexToColor(hexString: "##1ecc35", alpha: 1).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
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
        
        
        self.addSubview(searchTextField)
        self.addSubview(searchButton)
        self.addSubview(seachHistoryTableView)
        
        setConstraints()
        
    }
    

    
    fileprivate func setConstraints() {
        
        Constraints().constraintWithTopAndCenterXAnchor(field: searchTextField, width: UIElementSizes.textFieldWidth, height: 50, topAnchor: topAnchor, topConstant: UIElementSizes.navigationBarMaxY, centerXAnchor: centerXAnchor, centerXConstant: 0)
        
        Constraints().constraintWithTopAndCenterXAnchor(field: searchButton, width: UIElementSizes.buttonWidth, height: UIElementSizes.buttonHeight, topAnchor: searchTextField.bottomAnchor, topConstant: 25, centerXAnchor: centerXAnchor, centerXConstant: 0)
        
    }
    
}
