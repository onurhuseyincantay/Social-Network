//
//  PostCell.swift
//  SocialNetwork
//
//  Created by onur hüseyin çantay on 07/08/2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

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
    func configureCell ( post : Post ){
        self.post = post
        self.caption.text = post.caption
        self.lblLikes.text = "\(post.likes)"
        
    }

    
}
