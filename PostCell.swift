//
//  PostCell.swift
//  CricketInsta
//
//  Created by ebrahim on 11/11/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
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
    
    func configureCell(post:Post, img:UIImage? = nil){
       self.post=post
        self.caption.text=post.caption
        self.likesLabel.text="\(post.likes)"
        
        //SET IMAGE OR DOWNLOAD URL
        if img != nil{
            self.PostImg.image=img}
        else{
            let ref=FIRStorage.storage().reference(forURL: post.imageURL)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: {(data,error) in
                if error != nil{
                    print("FAIZEL: Unable to download image from Firebase Storage - \(error)")
                }
                else{
                    print("FAIZEL: Downloaded Image")
                    if let imgdata=data{  //if no error and image data exist
                        if let img=UIImage(data: imgdata){ //creates image from data
                            self.PostImg.image=img  //set the image
                            postVC.imgCache.setObject(img, forKey: post.imageURL as NSString) //adds image to the cache
                        }
                    }
                }
                })

           
       
            
        }
        
    }
}
