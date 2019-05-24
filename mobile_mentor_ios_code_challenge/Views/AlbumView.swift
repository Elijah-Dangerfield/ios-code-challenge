//
//  AlbumView.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by eli dangerfield on 5/24/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import Foundation
import UIKit

class AlbumView: UIView {
    
    var albumArtImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var albumTitleLabel: UILabel = {
        let textField = UILabel()
        textField.textAlignment = .left
        textField.textColor = #colorLiteral(red: 0.1422091424, green: 0.5657446384, blue: 0.8896750212, alpha: 1)
        textField.numberOfLines = 0
        textField.adjustsFontSizeToFitWidth = false
        textField.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    var artistNameLabel: UILabel = {
        let textField = UILabel()
        textField.textAlignment = .left
        textField.textColor = #colorLiteral(red: 0.7990349531, green: 0.2438177466, blue: 0.2458363473, alpha: 1)
        textField.numberOfLines = 0
        textField.adjustsFontSizeToFitWidth = false
        textField.font = UIFont(name: "AvenirNext-Regular", size: 12)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    var genreYearLabel: UILabel = {
        let textField = UILabel()
        textField.textAlignment = .left
        textField.textColor = #colorLiteral(red: 0.1427435577, green: 0.567597568, blue: 0.8905279636, alpha: 1)
        textField.adjustsFontSizeToFitWidth = false
        textField.font = UIFont(name: "AvenirNext-Regular", size: 12)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    
    var songResultsTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor().HexToColor(hexString: "#323F44", alpha: 1)
        tv.rowHeight = UIElementSizes.tableViewRowHeight_small
        return tv
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
        
        containerView.addSubview(albumTitleLabel)
        containerView.addSubview(artistNameLabel)
        containerView.addSubview(genreYearLabel)
        self.addSubview(containerView)
        self.addSubview(songResultsTableView)
        self.addSubview(albumArtImageView)
        setConstraints()
    }
    
    fileprivate func setConstraints() {
        
        Constraints().constraintWithTopAndLeadingAnchor(field: albumArtImageView, width: 100, height: 100, topAnchor: topAnchor, topConstant: 25 + UIElementSizes.navigationBarMaxY, leadingAnchor: leadingAnchor, leadingConstant: 25)
        
        Constraints().constraintWithTopAndLeadingAnchor(field: containerView, width: UIElementSizes.windowWidth - 175, height: 150, topAnchor: albumArtImageView.topAnchor, topConstant: 0, leadingAnchor: albumArtImageView.trailingAnchor, leadingConstant: 25)
        
        albumTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        albumTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        albumTitleLabel.widthAnchor.constraint(equalToConstant: UIElementSizes.windowWidth - 175).isActive = true

        artistNameLabel.topAnchor.constraint(equalTo: albumTitleLabel.bottomAnchor).isActive = true
        artistNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        artistNameLabel.widthAnchor.constraint(equalToConstant: UIElementSizes.windowWidth - 175).isActive = true

        genreYearLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor).isActive = true
        genreYearLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        genreYearLabel.widthAnchor.constraint(equalToConstant: UIElementSizes.windowWidth - 175).isActive = true

        songResultsTableView.topAnchor.constraint(equalTo: albumArtImageView.bottomAnchor, constant: 25).isActive = true
        songResultsTableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        songResultsTableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        songResultsTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
 
    }
    
}
