//
//  Post.swift
//  SocialNetwork
//
//  Created by onur hüseyin çantay on 19/09/2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import Foundation
import Firebase
class Post {
    private var _caption : String!
    private var _imgURL : String!
    private var _likes : Int!
    private var _postKey : String!
    private var _postRef : DatabaseReference!
    
    var caption : String {
        return _caption
    }
    var imgURL : String {
        return _imgURL
    }
    var likes : Int {
        return _likes
    }
    var postKey : String {
        return _postKey
    }
    
    init(caption : String , imgUrl : String , likes : Int) {
        self._caption = caption
        self._imgURL = imgUrl
        self._likes = likes
    }
    init(postKey : String , PostData : Dictionary<String,AnyObject>) {
        self._postKey = postKey
        if let caption = PostData["caption"] as? String{
            self._caption = caption
        }
        if let imageUrl = PostData["imageUrl"] as? String{
            self._imgURL = imageUrl
        }
        if let like = PostData["likes"] as? Int {
            self._likes = like
        }
        _postRef = DataService.ds.REF_POSTS.child(_postKey)
    }
    func adjustLikes (addLike : Bool ){
        if addLike {
            _likes = _likes + 1
        }else{
             _likes = _likes - 1
        }
        _postRef.child("likes").setValue(_likes)
    }
    
}
