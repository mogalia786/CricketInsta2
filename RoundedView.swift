//
//  RoundedView.swift
//  CricketInsta
//
//  Created by ebrahim on 11/10/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import UIKit

class RoundedView:UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor=UIColor.black.cgColor
        layer.shadowOffset=CGSize(width: 1.0, height: 1.0)
        layer.shadowRadius=0.5

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius=self.frame.width/2
        layer.cornerRadius=self.frame.height/2
        
    }
}
