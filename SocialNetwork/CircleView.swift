//
//  CircleView.swift
//  SocialNetwork
//
//  Created by onur hüseyin çantay on 07/08/2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
   
    override func layoutSubviews() {
        super.layoutSubviews()
         layer.cornerRadius = self.frame.width/2

    }
    
}
