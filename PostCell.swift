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
    @IBOutlet weak var LikeImg: CircleView!
    
    var post:Post!
    var likeRef:FIRDatabaseReference! //SETS LIKEREF as a Reference to Firebase database

    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        
        //ADDING A TAP GESTURE RECOGNIZER TO THE LIKE IMAGE---------THIS IS HOW ITS DONE IN A CELL PROGRAMMATICALLY COZ CELLS ARE CREATED ON THE FLY
        let tap=UITapGestureRecognizer(target: self, action: #selector(likeTapped)) // SAYS WHAT FUNCTION TO RUN WHEN TAPPED ......in this case 'LIKETAPPED'
        tap.numberOfTapsRequired=1
        LikeImg.addGestureRecognizer(tap)
        LikeImg.isUserInteractionEnabled=true
    
    
    }
    
    func configureCell(post:Post, img:UIImage? = nil){
        self.post=post
        let likeRef=DataService.ds.CURRENT_USER.child("likes") //Sets LikeRef to be the child of the CURRENT USER Reference in database
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
            //THESE LINES BASICALLY REACTS TO TAP AND CHANGES THE IMAGE FROM EMPTY TO FILLED HEART
               likeRef.observe(.value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.LikeImg.image=UIImage(named: "empty-heart")
            }else{
                    self.LikeImg.image=UIImage(named: "filled-heart")
                
            }
        })
        
    }
    
    //THIS FUNCTION BASICALLY REACTS TO TAP AND CHANGES THE IMAGE FROM EMPTY TO FILLED HEART
    func likeTapped(){
        likeRef.observe(.value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.LikeImg.image=UIImage(named: "filled-heart")
                self.post.adjustLikes(addLikes: true) //THIS LINE BASICALLY INCREASES THE LIKES VALUE FOR THIS POST
                self.likeRef.setValue(true) //THIS LINE BASICALLY SETS THE LIKES TO TRUE FOR A USER WHO LIKED A POST
                
            }else{
                self.LikeImg.image=UIImage(named: "empty-heart")
                self.post.adjustLikes(addLikes: false) //THIS LINE BASICALLY DECREASES THE LIKES VALUE FOR THIS POST
                self.likeRef.removeValue() //THIS LINE BASICALLY REMOVES LIKES  FOR A USER WHO UNLIKED A POST
            }
            })
    }
}
