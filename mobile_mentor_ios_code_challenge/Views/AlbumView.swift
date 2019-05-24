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
        
        self.addSubview(songResultsTableView)
        self.addSubview(albumArtImageView)
        setConstraints()
    }
    
    
    
    fileprivate func setConstraints() {
        
        Constraints().constraintWithTopAndCenterXAnchor(field: albumArtImageView, width: 200, height: 200, topAnchor:topAnchor, topConstant: UIElementSizes.navigationBarMaxY + 75, centerXAnchor: centerXAnchor, centerXConstant: 0)
        
        songResultsTableView.topAnchor.constraint(equalTo: albumArtImageView.bottomAnchor, constant: 25).isActive = true
        songResultsTableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        songResultsTableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        songResultsTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    
    }
    
}
