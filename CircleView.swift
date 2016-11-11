//
//  CircleView.swift
//  CricketInsta
//
//  Created by ebrahim on 11/11/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor=UIColor.black.cgColor
        layer.shadowOffset=CGSize(width: 1.0, height: 1.0)
        layer.shadowRadius=0.5
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius=self.frame.height/2

        
    }

}
