//
//  CircleView.swift
//  CricketInsta
//
//  Created by ebrahim on 11/11/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

  
    
    override func layoutSubviews() {
     
        layer.cornerRadius=self.frame.height/2
        clipsToBounds=true

    }

}
