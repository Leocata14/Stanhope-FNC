//
//  SignInVC.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 6/3/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import SwiftKeychainWrapper
import FBSDKCoreKit
import FBSDKLoginKit

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTextField: LargeTextField!
    @IBOutlet weak var passwordTextField: LargeTextField!
    
     @IBOutlet weak var signUpStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.signUpStackView.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("ID FOUND IN KEYCHAIN")
            self.signUpStackView.isHidden = true
            performSegue(withIdentifier: "goToNews", sender: nil)
            
        } else {
            self.signUpStackView.isHidden = false
            print("JASE: NO ID FOUND IN KEYCHAIN SOMETHING IS WRONG")
        }
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "idUnwindFromSignIn", sender: self)
    }
    
    @IBAction func unwindToSignIn(_ sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func LoginTapped(_ sender: Any) {
        //self.performSegue(withIdentifier: "idUnwindFromSignIn", sender: self)
        if let email = emailTextField.text, let pwd = passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("JASE: Email User authenticated with Firebase")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                    
                } else {
                    
                }
            })
        } else {
            print("Email or Password not entered")
        }
    }
    
    @IBAction func facebookButtonTapped(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, error) in
            if error != nil {
                print("JASE: Unable to authenticate with Facebook")
            } else if result?.isCancelled == true {
                print("JASE: User cancelled Facebook Auth")
            } else {
                print("JASE: Successfully authenticated ith Fcebook")
                //Save to Fireabse here
                
                
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
        
        
        
    }
    
    
    
    
    override func segueForUnwinding(to toViewController: UIViewController, from fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue {
        if let id = identifier{
            if id == "idUnwindToSignIn" {
                let unwindSegue = UnwindSegueFromLeft(identifier: id, source: fromViewController, destination: toViewController, performHandler: { () -> Void in
                    
                })
                return unwindSegue
            }
        }
        
        return super.segueForUnwinding(to: toViewController, from: fromViewController, identifier: identifier)!
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("JASE: Unable to authenticate with Firebase - \(error)")
            } else {
                print("JASE: Successfully authenticated with Firebase")
                if let user = user {
                    //Save to Firebase here
                    let uservalues = ["email":user.email,"provider":"Facebook","name":user.displayName]
                    let uid = user.uid
                    DataService.ds.REF_USERS.child(uid).updateChildValues(uservalues, withCompletionBlock: { (error, ref) in
                        if error != nil {
                            //Something wrong
                            print(error)
                        } else {
                            print("JASE: Saved to Firbase Database!")
                        }
                    })
                    
                    
                    self.completeSignIn(id: user.uid)
                }
                
            }
        })
    }
    
    func completeSignIn(id: String) {
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("JASE: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "LoginGoToNews", sender: nil)
    }


}
