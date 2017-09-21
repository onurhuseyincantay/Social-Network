//
//  PostCell.swift
//  SocialNetwork
//
//  Created by onur hüseyin çantay on 07/08/2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg : UIImageView!
    @IBOutlet weak var lblUserName : UILabel!
    @IBOutlet weak var postImg : UIImageView!
    @IBOutlet weak var caption : UITextView!
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var lblLikes : UILabel!
    var post : Post!
    var likeRef :DatabaseReference! 
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        imgLike.addGestureRecognizer(tap)
        imgLike.isUserInteractionEnabled = true
        
        // Initialization code
    }
    func configureCell ( post : Post , image : UIImage? = nil ){
        self.post = post
       likeRef = DataService.ds.REF_CURRENT_USER.child("likes").child(post.postKey)
        self.caption.text = post.caption
        self.lblLikes.text = "\(post.likes)"
        
        if image != nil {
            self.postImg.image = image
        }else
        {
            let ref = Firebase.Storage.storage().reference(forURL: post.imgURL)
            ref.getData(maxSize : 2 * 1024 * 1024 , completion : { (data, error) in
                if error != nil {
                    print("Onur : Unable To Download")
                }else {
                    print("Onur : Download Completed")
                    if let imageData = data {
                        if let img = UIImage(data : imageData){
                            self.postImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imgURL as NSString)
                        }
                    }
                }
                
            })
        }

        likeRef.observeSingleEvent(of: .value, with: {(snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.imgLike.image = UIImage(named : "empty-heart")
            }else {
                self.imgLike.image = UIImage(named : "filled-heart")
            }
            
            
        })
       
    }

    func likeTapped (sender : UITapGestureRecognizer) {
        likeRef.observeSingleEvent(of: .value, with: {(snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.imgLike.image = UIImage(named : "filled-heart")
                self.post.adjustLikes(addLike: true)
                self.likeRef.setValue(true)
            }else {
                self.imgLike.image = UIImage(named : "empty-heart")
                self.post.adjustLikes(addLike: false)
                self.likeRef.removeValue()
            }
            
            
        })
    }
}
