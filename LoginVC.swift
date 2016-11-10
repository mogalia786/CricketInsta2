//
//  ViewController.swift
//  CricketInsta
//
//  Created by ebrahim on 11/10/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
class LoginVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var pwdField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

   
    @IBAction func facebookBtnTapped(_ sender: AnyObject) {
        let facebookLogin=FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print ("FAIZEL: Error logging into Facebook - \(error)")
            }
            else if result?.isCancelled == true{
                
                print("FAIZEL: User Cancelled Facebook Authentication")
            }
            else{
                let credential=FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential: credential)
            print("FAIZEL: Facebook Login successful!")
            }
        }
        
    }
    func firebaseAuth(credential: FIRAuthCredential){
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                
                print("FAIZEL: Firebase authenticate unsuccessful - \(error)")
            }else{
                
                print("FAIZEL: Firebase authenticate successfully!")
            }
        })
        
        
        
    }
    
    
    @IBAction func emailSignInTapped(_ sender: AnyObject) {
        
        if let email=emailField.text, let pwd=pwdField.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil{
                    print("FAIZEL: Email User authenticated with Firebasw")
                
                }else{
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil{
                            print("FAIZEL: Email User failed to authenticate with Firebase - \(error)")
                        }else{
                            print("FAIZEL: Email User successfully created and athenticated with Firebase")
                            
                        }
                    })
                }
            })
        }
    }
    
    
    
    
    
    

}
























