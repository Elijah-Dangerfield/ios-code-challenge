//
//  ResultsTableViewCell.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by eli dangerfield on 5/23/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//
import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    var albumTitleLabel: UILabel = {
        let textField = UILabel()
        textField.textAlignment = .left
        textField.textColor = #colorLiteral(red: 0.1422091424, green: 0.5657446384, blue: 0.8896750212, alpha: 1)
        textField.font = UIFont(name: "AvenirNext-Bold", size: 22)
        textField.layer.masksToBounds = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        
        return textField
    }()
    
    
    var artistTitleLabel: UILabel = {
        let textField = UILabel()
        textField.textAlignment = .left
        textField.textColor = UIColor().HexToColor(hexString: "#0463AC", alpha: 1)
        textField.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        textField.layer.masksToBounds = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    var resultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "results_cell")
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
        
    }
    
    fileprivate func setupView() {
        
        backgroundColor = UIColor().HexToColor(hexString: "#323F44", alpha: 1)
        containerView.addSubview(artistTitleLabel)
        containerView.addSubview(albumTitleLabel)
        contentView.addSubview(resultImageView)
        contentView.addSubview(containerView)

        setConstraints()
        
    }
    
    
    
    fileprivate func setConstraints() {
        
    Constraints().constraintWithCenterYAnchorAndLeading(field: resultImageView, width: 100, height: 100, centerYAnchor: centerYAnchor, centerYConstant: 0, leadingAnchor: leadingAnchor, leadingConstant: 25)
        
    Constraints().constraintWithTopAndLeadingAnchor(field: containerView, width: UIElementSizes.cellLabelMaxWidth, height: 300, topAnchor: resultImageView.topAnchor, topConstant:  0, leadingAnchor: resultImageView.trailingAnchor, leadingConstant: 30)
        
    Constraints().constraintWithTopAndLeadingAnchor(field: albumTitleLabel, width: UIElementSizes.windowWidth - resultImageView.bounds.width - 50, height: 30, topAnchor: containerView.topAnchor, topConstant: 0, leadingAnchor: containerView.leadingAnchor, leadingConstant: 0)
        
    Constraints().constraintWithTopAndLeadingAnchor(field: artistTitleLabel, width: UIElementSizes.windowWidth - resultImageView.bounds.width - 50, height: 30, topAnchor: albumTitleLabel.bottomAnchor, topConstant: 0, leadingAnchor: containerView.leadingAnchor, leadingConstant: 0)
        
    }

}

