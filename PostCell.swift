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
    
    var post:Post!
    
    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post:Post){
       self.post=post
        self.caption.text=post.caption
        self.likesLabel.text="\(post.likes)"
        
    }
  
}
