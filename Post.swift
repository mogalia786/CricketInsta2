//
//  Post.swift
//  CricketInsta
//
//  Created by ebrahim on 11/11/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import Foundation
import Firebase

class Post{
    
    private var _caption: String!
    private var _username: String!
    private var _imageURL: String!
    private var _imageURLprofile: String!
    private var _likes: Int!
    private var _postKey: String!
    private var _postRef: FIRDatabaseReference! //THIS LINE SETS A REFERENCE TO DATABASE REFERENCE TO BE USED BELOW
    
    var caption:String{
        return _caption
    }
    
    var imageURL:String{
        return _imageURL
    }
    var imageURLprofile:String{
        if let _ = _imageURLprofile {
        return _imageURLprofile
        }
        return ""
    }

    
    var likes: Int{
        return _likes
    }
    
    var postKey: String{
        return _postKey
    }
    
    var Username:String{
        if let _ = _username{
        return _username
        }else{
            return ""
        }
    }

    init(caption: String, imageURL:String, likes: Int){
        self._caption=caption
        self._imageURL=imageURL
        self._likes=likes
        
    }
    
    
    init(postKey:String, userData:Dictionary<String, AnyObject>){
        self._postKey=postKey
        if let caption=userData["Caption"] as? String{
            self._caption=caption
        }
        
        if let imageURL=userData["imgURL"] as? String{
            self._imageURL=imageURL
        }
        if (userData["imgProfile"] as? String) != nil{
            self._imageURLprofile=imageURLprofile
        }

        
        if let likes=userData["likes"] as? Int{
            self._likes=likes
        }
        
        if let Username=userData["Username"] as? String{
            self._username=Username
        }
        _postRef=DataService.ds.REF_POSTS.child(_postKey) //THIS LINE CREATES A DATABASE REFERENCE TO THE POSTKEY FOR SELECTED POST
        
    }
    
    func adjustLikes(addLikes: Bool){
        if addLikes {
            _likes = _likes+1
        }else{
            _likes = _likes-1
            
        }
        _postRef.child("likes").setValue(_likes) ///THIS IMPORTANT LINE SETS THE LIKES VALUE FOR A POST TO A VALUE SET ABOVE
    }
    
    
}
