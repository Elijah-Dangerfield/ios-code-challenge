//
//  SongsTableViewCell.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by eli dangerfield on 5/24/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import Foundation
import UIKit

class SongsTableViewCell: UITableViewCell {
    
    var songTitleLabel: UILabel = {
        let textField = UILabel()
        textField.textAlignment = .left
        textField.textColor = UIColor().HexToColor(hexString: "#0463AC", alpha: 1)
        textField.font = UIFont(name: "AvenirNext-Regular", size: 18)
        textField.layer.masksToBounds = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    var songNumberLabel: UILabel = {
        let textField = UILabel()
        textField.textAlignment = .left
        textField.textColor = UIColor().HexToColor(hexString: "#0463AC", alpha: 1)
        textField.font = UIFont(name: "AvenirNext-Regular", size: 18)
        textField.layer.masksToBounds = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "song_cell")
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
        
    }
    
    fileprivate func setupView() {
        
        backgroundColor = UIColor().HexToColor(hexString: "#323F44", alpha: 1)
        
        contentView.addSubview(songTitleLabel)
        contentView.addSubview(songNumberLabel)

        
        setConstraints()
        
    }
    
    
    
    fileprivate func setConstraints() {
        
        Constraints().constraintWithCenterYAnchorAndLeading(field: songNumberLabel, width: 50, height: UIElementSizes.cellLabelHeight, centerYAnchor: centerYAnchor, centerYConstant: 0, leadingAnchor: leadingAnchor, leadingConstant: 25)
        
         Constraints().constraintWithCenterYAnchorAndLeading(field: songTitleLabel, width: UIElementSizes.windowWidth - 100, height: UIElementSizes.cellLabelHeight, centerYAnchor: centerYAnchor, centerYConstant: 0, leadingAnchor: songNumberLabel.trailingAnchor, leadingConstant: -25)
        
    }
    
}
