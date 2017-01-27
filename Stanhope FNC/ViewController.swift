//
//  ViewController.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 17/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftKeychainWrapper


class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: LargeTextField!
    @IBOutlet weak var passwordTextField: LargeTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("ID FOUND IN KEYCHAIN")
            performSegue(withIdentifier: "goToNews", sender: nil)
        } else {
            print("JASE: NO ID FOUND IN KEYCHAIN SOMETHING IS WRONG")
        }
    }

    @IBAction func emailButtonTapped(_ sender: AnyObject) {
        if let email = emailTextField.text, let pwd = passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("JASE: Email User authenticated with Firebase")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                    
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("JASE: Something went wrong. Unable to create user with Email")
                        } else {
                            print("JASE: Successfully authenticated with Firebase/Email")
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                        }
                    })
                }
            })
        } else {
            print("Email or Password not entered")
        }
    }

    @IBAction func facebookButtonTapped(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("JASE: Unable to authenticate with Facebook")
            } else if result?.isCancelled == true {
                print("JASE: User cancelled FAcebook Auth")
            } else {
                print("JASE: Successfully authenticated ith Fcebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }

        

    }
    
    func getConfig() {
        
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("JASE: Unable to authenticate with Firebase - \(error)")
            } else {
                print("JASE: Successfully authenticated with Firebase")
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
                
            }
        })
    }
    
    func showErrorAlert(title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func completeSignIn(id: String) {
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("JASE: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "goToNews", sender: nil)
    }
}

