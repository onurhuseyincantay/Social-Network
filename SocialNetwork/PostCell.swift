//
//  PostCell.swift
//  SocialNetwork
//
//  Created by onur hüseyin çantay on 07/08/2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var profileImg : UIImageView!
    @IBOutlet weak var lblUserName : UILabel!
    @IBOutlet weak var postImg : UIImageView!
    @IBOutlet weak var caption : UITextView!
    @IBOutlet weak var lblLikes : UILabel!
    
}
