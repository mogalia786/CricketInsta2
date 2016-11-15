//
//  DataService.swift
//  CricketInsta
//
//  Created by ebrahim on 11/11/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

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
    private var _REF_PROFILE=DB_BASE.child("Profiles")
    
    //STORAGE REFERENCE
    private var _REF_POST_Image=DB_STORAGE.child("post-pics")
    private var _REF_PROFILE_Image=DB_STORAGE.child("Profile-Pics")
    
    var REF_BASE:FIRDatabaseReference{
        return _REF_BASE
    }
    
    
    var REF_POSTS:FIRDatabaseReference{
        
        return _REF_POSTS
    }
    
    
    var REF_USERS:FIRDatabaseReference{
        
        return _REF_USERS
    }
    
    var REF_PROFILE: FIRDatabaseReference{
        return _REF_PROFILE
    }
    
    var CURRENT_USER: FIRDatabaseReference{
        let uid=KeychainWrapper.standard.string(forKey: KEY_UID)
        let user=REF_USERS.child(uid!)
        return user
        
    }
    
    
    var REF_POST_IMAGE:FIRStorageReference{
    
    return _REF_POST_Image
    }
    
    var REF_PROFILE_IMAGE:FIRStorageReference{
        return _REF_PROFILE_Image
    }
    
    func createFIRDBuser(uid: String, userData:Dictionary<String,String>){
        REF_USERS.child(uid).updateChildValues(userData)
        
        
    }
    
    
    
}
