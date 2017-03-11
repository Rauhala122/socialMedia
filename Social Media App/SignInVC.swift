//
//  ViewController.swift
//  Social Media App
//
//  Created by Saska Rauhala on 8.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper


class SignInVC: UIViewController {

    @IBOutlet weak var passField: FancyField!
    @IBOutlet weak var emailField: FancyField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("SASKA: ID found in keychain")
            performSegue(withIdentifier: "FeedVC", sender: nil)
        }
    }

    @IBAction func facebookBtnPressed(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("RAUHALA: Unable with facebook - \(error)")
                
            } else if result?.isCancelled == true {
                print("SASKA: User cancelled facebook auth")
            } else {
                print("SASKA: Succesfully auth with facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
                
                
            }
        }
        
    }
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("SASKA: Unable to facebook autht with Firebase - \(error)")

            } else {
                print("SASKA: Successfully auth with Firebase")
                
                if let user = user {
               
                    self.completedSignIn(id: user.uid)
                    
                }
        }
        })
    }
    @IBAction func signInPressed(_ sender: Any) {
        
        if let email = emailField.text, let pass = passField.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: { (user, error) in
                if error == nil {
                    print("SASKA: User Signed in with Firebase")
                
                    if let user = user {
                        self.completedSignIn(id: user.uid)
                    }
                  
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pass, completion: { (user, error) in
                        if error != nil {
                            print("SASKA: Unable to auth with Firebase email")
                        } else {
                            print("SASKA: Firebase user created")
                            if let user = user {
                            self.completedSignIn(id: user.uid)
                            }
                         }
                     })
                  }
                
              })
            
          }
        
      }
    
    
    func  completedSignIn(id: String) {
        let keychainresult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("SASKA: Data saved to keychain \(keychainresult)")
        performSegue(withIdentifier: "FeedVC", sender: nil)
    }
    
}


    
