//
//  PostCell.swift
//  CricketInsta
//
//  Created by ebrahim on 11/11/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
   
    @IBOutlet weak var username:UILabel!
    @IBOutlet weak var caption:UITextView!
    @IBOutlet weak var likesLabel:UILabel!
    @IBOutlet weak var PostImg: UIImageView!
    @IBOutlet weak var pfIMG: CircleView!
    
    
    
    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        // Initialization code
    }

  
}
