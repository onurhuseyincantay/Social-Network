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
    @IBOutlet weak var lblLikes : UILabel!
    var post : Post!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell ( post : Post , image : UIImage? = nil ){
        self.post = post
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
    }

    
}
