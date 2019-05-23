//
//  ResultsView.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by eli dangerfield on 5/23/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import UIKit

class ResultsView: UIView {
    
 
    
    var resultsTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor().HexToColor(hexString: "#323F44", alpha: 1)
        tv.rowHeight = UIElementSizes.tableViewRowHeight_large
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
        
        
        self.addSubview(resultsTableView)

        setConstraints()
    
    }
    
    
    
    fileprivate func setConstraints() {
        
        Constraints().constraintWithTopAndCenterXAnchor(field: resultsTableView, width: UIElementSizes.windowWidth, height: UIElementSizes.windowHeight, topAnchor: topAnchor, topConstant: 0, centerXAnchor: centerXAnchor, centerXConstant: 0)
    }
    
}

