//
//  DataService.swift
//  SocialNetwork
//
//  Created by onur hüseyin çantay on 09/08/2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Firebase.Database.database().reference()

class DataService {
    
    static let ds = DataService() //Singleton
    
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    var REF_BASE : DatabaseReference {
        return _REF_BASE
    }
    var REF_POSTS : DatabaseReference{
        return _REF_POSTS
    }
    var REF_USERS : DatabaseReference{
        return _REF_USERS
    }
    
    func createFirebaseDBUser(uid : String , userData: Dictionary <String,String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
}
