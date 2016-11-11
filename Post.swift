//
//  Post.swift
//  CricketInsta
//
//  Created by ebrahim on 11/11/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import Foundation

class Post{
    
    private var _caption: String!
    private var _imageURL: String!
    private var _likes: Int!
    private var _postKey: String!
    
    var caption:String{
        return _caption
    }
    
    var imageURL:String{
        return _imageURL
    }
    
    var likes: Int{
        return _likes
    }
    
    var postKey: String{
        return _postKey
    }
    
    
    init(caption: String, imageURL:String, likes: Int){
        self._caption=caption
        self._imageURL=imageURL
        self._likes=likes
        
    }
    
    
    init(postKey:String, userData:Dictionary<String, AnyObject>){
        if let caption=userData["Caption"] as? String{
            self._caption=caption
        }
        
        if let imageURL=userData["imgURL"] as? String{
            self._imageURL=imageURL
        }
        
        if let likes=userData["likes"] as? Int{
            self._likes=likes
        }
        
    }
    
    
    
    
}