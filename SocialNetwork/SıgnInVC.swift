//
//  ViewController.swift
//  SocialNetwork
//
//  Created by onur hüseyin çantay on 04/08/2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
class SignInVC: UIViewController {
    @IBOutlet weak var txtEmailAddress: FTextField!
    @IBOutlet weak var txtPassword: FTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func KeyboardHiding(_ sender: FTextField) {
        sender.resignFirstResponder()
    }
    

    @IBAction func fbButtonClicked(_ sender: AnyObject) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"] , from: self){ (result,error) in
            if error != nil {
                print("Onur: Unable to Authenticate with Facebook- \(error.debugDescription)")
            }else if result?.isCancelled == true{
                print("Onur: User Canceled the Facebook Authentication " )
            }else{
                print("Onur: Succesfully authenticated to Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }

    @IBAction func btnSignInClicked(_ sender: Any) {
        if let email = txtEmailAddress.text , let pass = txtPassword.text {
            Firebase.Auth.auth().signIn(withEmail: email, password: pass, completion: {(user , error) in
                if error == nil {
                    print("Onur :  Email authenticated with Firebase")
                }else{
                    Firebase.Auth.auth().createUser(withEmail: email, password: pass, completion:{(user,error) in
                        if error != nil {
                            print("Onur : Unable to Authenticated with Firebase")
                        }else{
                            
                            print("Onur : Succesfully Authenticated with Firebase")
                        }
                    })
                }
        })
        }
    }

    func firebaseAuth(_ credential : AuthCredential) {
        Firebase.Auth.auth().signIn(with: credential, completion: { (user , error ) in
            if error != nil {
                print("Onur: Unable to Authenticate with Firebase :( -\(error.debugDescription)")
            }else{
                print("Onur : Succesfully Authenticated with Firebase ")
            }
        })
    
    
    




    }

}

