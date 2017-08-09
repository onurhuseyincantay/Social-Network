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
class FeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
        print(snapshot.value)
        
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    @IBAction func btnSignOutClicked(_ sender: UIButton)
    {
        let keyChainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("Onur : Keychain  Has Been Removed \(keyChainResult)")
        try! Firebase.Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
   

}
