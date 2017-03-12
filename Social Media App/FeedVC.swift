//
//  FeedVC.swift
//  Social Media App
//
//  Created by Saska Rauhala on 11.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addedImage: Circleimage!
    @IBOutlet weak var tableView: UITableView!

    var posts = [Post]()

    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            
            self.posts = []

            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                      
                    }
                }
            }
              self.tableView.reloadData()
            
        })
        
    }
    
    // Tableview Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            let post = posts[indexPath.row]
            cell.updateUi(post: post)
            return cell
        } else {
        
        return PostCell()
        }
    
}
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
        
               addedImage.image = image
        }
            imagePicker.dismiss(animated: true, completion: nil)

        
}
    
    @IBAction func imagePickerPressed(_ sender: Any) {
      print("imagepicker tapped")
        present(imagePicker, animated: true, completion: nil)
    }
    
    

    @IBAction func signOut(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.remove(key: KEY_UID)
        print("SASKA: ID removed in kaychain \(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
        
    }
}
