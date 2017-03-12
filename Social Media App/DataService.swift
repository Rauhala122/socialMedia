//  DataService.swift
//  Social Media App
//
//  Created by Saska Rauhala on 12.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()


class DataService {
    
     static let ds = DataService()
    
    
    //Db refrences
    private var _REF_BASE  = DB_BASE
    private var _REF_POSTS  = DB_BASE.child("posts")
    private var _REF_USERS  = DB_BASE.child("users")
    
    // Storage refrences
    
    private var _REF_POSTS_IMAGES = STORAGE_BASE.child("post-pics")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_POSTS_IMAGES: FIRStorageReference {
        return _REF_POSTS_IMAGES
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
    
}
