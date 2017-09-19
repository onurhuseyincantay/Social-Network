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
    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshots {
                    print("SNAP : \(snap)")
                    if let postDict = snap.value as? Dictionary <String , AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, PostData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        print("Onur : \(post.caption)")
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
