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
import SwiftKeychainWrapper

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var pwdField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    override func viewDidAppear(_ animated: Bool) {
        if let _=KeychainWrapper.standard.string(forKey: KEY_UID){
  
            performSegue(withIdentifier: "ShowPostVC", sender: nil)
        }
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
                let alert = UIAlertController(title: "Sign in Successfull for user", message: "Message", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Proceed", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    func firebaseAuth(credential: FIRAuthCredential){
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                
                print("FAIZEL: Firebase authenticate unsuccessful - \(error)")
            }else{
                if let user=user{
                    let userData=["Provider":credential.provider]
                    self.completeSignIn(email: user.email!, id: user.uid, userData: userData)
                                    }
                print("FAIZEL: Firebase authenticate successfully!")
            }
        })
        
        
        
    }
    
    
    @IBAction func emailSignInTapped(_ sender: AnyObject) {
        
        if let email=emailField.text, let pwd=pwdField.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil{
                    let userData=["provider":user?.providerID]
                    self.completeSignIn(email: email, id: (user?.uid)!,userData: (userData as! Dictionary<String, String>))
                    print("FAIZEL: Email User authenticated with Firebase")
                
                }else{
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil{
                            print("FAIZEL: Email User failed to authenticate with Firebase - \(error) for user: \(user?.email)")
                            let alert = UIAlertController(title: "Sign in Failed", message: "Failed to Authenticate! \(error?.localizedDescription) for user \(email)", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }else{
                            let userData=["provider":user?.providerID]
                            self.completeSignIn(email: email, id: (user?.uid)!,userData: userData as! Dictionary<String, String>)
                            print("FAIZEL: Email User successfully created and athenticated with Firebase")
                            
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(email: String, id: String, userData:Dictionary<String,String>){
        DataService.ds.createFIRDBuser(uid: id, userData: userData)
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        KeychainWrapper.standard.set(email, forKey: EMAIL)
        performSegue(withIdentifier: "ShowPostVC", sender: nil)
        
 
    }
    
    
    
    

}
























