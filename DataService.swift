//
//  DataService.swift
//  CricketInsta
//
//  Created by ebrahim on 11/11/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import UIKit
import Firebase

///This line makes reference to the URL of the database
let DB_BASE=FIRDatabase.database().reference()
let DB_STORAGE=FIRStorage.storage().reference()

class DataService{
    
    //Make class into a SINGLETON using following line
    
    static let ds=DataService()
    //DATASE REFERENCE
    private var _REF_BASE=DB_BASE
    private var _REF_POSTS=DB_BASE.child("Post")
    private var _REF_USERS=DB_BASE.child("Users")
    
    //STORAGE REFERENCE
    private var _REF_POST_Image=DB_STORAGE.child("post-pics")
    
    
    var REF_BASE:FIRDatabaseReference{
        return _REF_BASE
    }
    
    
    var REF_POSTS:FIRDatabaseReference{
        
        return _REF_POSTS
    }
    
    var REF_USERS:FIRDatabaseReference{
        
        return _REF_USERS
    }
    
    var REF_POST_IMAGE:FIRStorageReference{
    
    return _REF_POST_Image
    }
    
    
    
    func createFIRDBuser(uid: String, userData:Dictionary<String,String>){
        REF_USERS.child(uid).updateChildValues(userData)
        
        
    }
    
    
    
}
