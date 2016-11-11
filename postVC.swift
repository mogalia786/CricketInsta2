//
//  postVC.swift
//  CricketInsta
//
//  Created by ebrahim on 11/10/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class postVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        
        //This line is the OBSERVER that listens to Firebase for any changes and returns a snapshot
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            print(snapshot.value)
        })
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    
    
    @IBAction func signOutBtn(_ sender: AnyObject) {
        let _=KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "signOUT", sender: self)
    }
    
    
   }
