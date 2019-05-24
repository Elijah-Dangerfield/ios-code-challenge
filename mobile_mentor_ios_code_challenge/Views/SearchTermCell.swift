//
//  SearchTermCell.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by eli dangerfield on 5/22/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import UIKit

class SearchTermCell: UITableViewCell {
    
    var searchTermLable: UILabel = {
        let textField = UILabel()
        textField.textAlignment = .left
        textField.textColor = UIColor().HexToColor(hexString: "#0463AC", alpha: 1)
        textField.font = UIFont(name: "AvenirNext-Regular", size: 18)
        textField.layer.masksToBounds = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    var timeStampLable: UILabel = {
        let textField = UILabel()
        textField.textAlignment = .right
        textField.textColor = UIColor().HexToColor(hexString: "#0463AC", alpha: 1)
        textField.font = UIFont(name: "AvenirNext-Regular", size: 18)
        textField.layer.masksToBounds = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "search_term_cell")
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    fileprivate func setupView() {
        
        backgroundColor = UIColor().HexToColor(hexString: "#323F44", alpha: 1)
        
        contentView.addSubview(timeStampLable)
        contentView.addSubview(searchTermLable)
        
        setConstraints()
        
    }
  
    fileprivate func setConstraints() {
        
        let padding: CGFloat = 2.0
        let centerConstantForLabel = (self.bounds.height - 30)/2
        
        Constraints().constraintWithTopAndLeadingAnchor(field: searchTermLable, width: UIElementSizes.cellLabelMaxWidth - padding ,height: UIElementSizes.cellLabelHeight ,topAnchor: self.topAnchor, topConstant: centerConstantForLabel, leadingAnchor: self.leadingAnchor, leadingConstant: padding)
        
         Constraints().constraintWithTopAndLeadingAnchor(field: timeStampLable, width: UIElementSizes.cellLabelMaxWidth - padding ,height: UIElementSizes.cellLabelHeight ,topAnchor: self.topAnchor, topConstant: centerConstantForLabel, leadingAnchor: searchTermLable.trailingAnchor, leadingConstant: -padding)
    }
    
}
