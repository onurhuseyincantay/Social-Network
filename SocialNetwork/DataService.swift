//
//  DataService.swift
//  SocialNetwork
//
//  Created by onur hüseyin çantay on 09/08/2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper
let DB_BASE = Firebase.Database.database().reference()
let DB_STORAGEBASE = Firebase.Storage.storage().reference()
class DataService {
    
    static let ds = DataService() //Singleton
    
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    private var _REF_POST_IMAGES = DB_STORAGEBASE.child("post-pics")
    
    var REF_BASE : DatabaseReference {
        return _REF_BASE
    }
    var REF_POSTS : DatabaseReference{
        return _REF_POSTS
    }
    var REF_USERS : DatabaseReference{
        return _REF_USERS
    }
    var REF_CURRENT_USER : DatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
    var REF_POST_IMAGES : StorageReference {
        return _REF_POST_IMAGES
    }
    func createFirebaseDBUser(uid : String , userData: Dictionary <String,String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
}
