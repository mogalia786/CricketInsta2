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



class postVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgAdd: CircleView!
    @IBOutlet weak var tableView: UITableView!
     var Posts=[Post]()
    
    //Create ImagePicker of type UIImagePickerController
    var imagePicker:UIImagePickerController!
    
    //Create Cache to store Image
    static var imgCache:NSCache<NSString, UIImage>=NSCache()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup tableview with delegate and datasource
        tableView.delegate=self
        tableView.dataSource=self
        //////////////////////////////////////////////////
        
        
        //setup imagePicker with UIImagepickerControllerDelegate. Allow Editing and delegate
        imagePicker=UIImagePickerController()
        imagePicker.allowsEditing=true
        imagePicker.delegate=self
        //////////////////////////////////////////////////////////////////////////////////////////
        
        //This line is the OBSERVER that listens to Firebase for any changes and returns a snapshot
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            //create a snapshot based on snapshot childrens all object from FIRdataSnapshot
            if let snapshot=snapshot.children.allObjects as? [FIRDataSnapshot]{
                //Run through each snap in snapshot
                for snap in snapshot{
                    //snap.value is a dictionary of post object in Firebase. now we create a dictionary object to pass to the post class to initialise and set values
                    if let postDict=snap.value as? Dictionary<String, AnyObject>{
                        let key=snap.key
                        
                        
                        //Create post opject by initialising Post object
                        let post=Post(postKey: key, userData: postDict)
                        
                        
                        ////Append the post object to the Posts []
                        self.Posts.append(post)
                                            }
                }
            }
            self.tableView.reloadData()
        })
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //READ the Post Array and call the specific element based on indexPth.row as index for the array
        let post=Posts[indexPath.row]
        //Create a cell making reference to the PostCell class that needs to be configured
        if let cell=tableView.dequeueReusableCell(withIdentifier: "PostCell")as? PostCell{
            //Configure the cell with the sing Post object from the array and display on TableCell
                            //CACHE CHECK!!!!!!! for image
            if let img=postVC.imgCache.object(forKey: post.imageURL as NSString){
                cell.configureCell(post: post, img: img)
                return cell
                //////////IF NO IMAGE
            }else{
                cell.configureCell(post: post)
            return cell
            }
            ////IF NO CELL
        }else{
            
            return PostCell()
        }
    }
        
    //THIS Function is called to load the image to the Image View
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image=info[UIImagePickerControllerEditedImage] as? UIImage{
            imgAdd.image=image
            }else
        {
            print("FAIZEL: Image was not correctly uploaded")        }
        dismiss(animated: true, completion: nil)
    }
    
    ///////////////////////////////////////////////////////////////////////////
    
    @IBAction func addImageTapped(_ sender: AnyObject) {
        //dont forget to set info.plist Privacy Photo Library Usage and description
      present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func signOutBtn(_ sender: AnyObject) {
        let _=KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "signOUT", sender: self)
    }
    
    
   }
