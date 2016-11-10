//
//  FancyView.swift
//  CricketInsta
//
//  Created by ebrahim on 11/10/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import UIKit

class FancyView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor=UIColor.black.cgColor
        layer.shadowOffset=CGSize(width: 1.0, height: 1.0)
        layer.shadowRadius=0.5
        
    }
    
    
}
