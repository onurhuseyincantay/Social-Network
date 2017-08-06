//
//  FeedVCV.swift
//  SocialNetwork
//
//  Created by onur hüseyin çantay on 06/08/2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase
class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnSignOutClicked(_ sender: UIButton)
    {
        let keyChainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("Onur : Keychain  Has Been Removed \(keyChainResult)")
        try! Firebase.Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
   

}
