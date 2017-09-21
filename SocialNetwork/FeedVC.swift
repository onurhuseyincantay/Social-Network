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
var imageSelected = false
class FeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var captionField: FTextField!
    @IBOutlet weak var addImage: CircleView!
    var posts = [Post]()
    static var imageCache : NSCache <NSString, UIImage> = NSCache()
    var imagePicker : UIImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            addImage.image = image
            imageSelected = true
        }else{
            print("Onur : a valid image wasn't chosen")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func addImageTapped(_ sender: Any) {
        present(imagePicker, animated: true , completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
             let post = posts[indexPath.row]
            if let img = FeedVC.imageCache.object(forKey: post.imgURL as NSString){
             cell.configureCell(post: post, image:  img)
            }
            else{
                cell.configureCell(post: post)
            }
           return cell
        }
        return PostCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func postButtonTapped(_ sender: Any) {
        guard let caption = captionField.text , caption != "" else {
            print("Onur : Must be an caption")
            return
        }
        guard let img = addImage.image , imageSelected == true else {
            print("Onur : Must be an İmage")
            return
        }
        if let imageData = UIImageJPEGRepresentation(img, 0.2){
            
            let imgUid = NSUUID().uuidString
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpeg"
            DataService.ds.REF_POST_IMAGES.child(imgUid).putData(imageData, metadata: metaData) {(metadata,error) in
                if error != nil {
                    print("Onur : Unable to upload İmage")
                }else {
                    print("Onur : SuccesFully Downloaded İmage to the FireBase")
                    let downloadURl = metadata?.downloadURL()?.absoluteString
                    if let url = downloadURl {
                        self.postToFirebase(imgURl: url)
                    }
                    
                }
                
                
            }
        }
        
    }
    func postToFirebase(imgURl : String)  {
        let post : Dictionary < String,AnyObject> = [
            "caption" : captionField.text! as AnyObject ,
            "imageUrl" : imgURl as AnyObject,
            "likes" : 0 as AnyObject
    ]
        addImage.image = UIImage(named : "add-image")
        imageSelected = false
        captionField.text = ""
        tableView.reloadData()
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
    }
    @IBAction func btnSignOutClicked(_ sender: UIButton)
    {
        let keyChainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("Onur : Keychain  Has Been Removed \(keyChainResult)")
        try! Firebase.Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
   

}
