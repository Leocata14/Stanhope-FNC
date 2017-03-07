//
//  WelcomeVC.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 5/3/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Foundation
import SwiftKeychainWrapper
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth
import Firebase

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("ID FOUND IN KEYCHAIN")
            performSegue(withIdentifier: "goToNews", sender: nil)
        } else {
            print("JASE: NO ID FOUND IN KEYCHAIN SOMETHING IS WRONG")
        }
    }


    @IBAction func signUpWithEmailTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "signUpWithEmail", sender: self)
        
        
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "signIn", sender: self)
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
        performSegue(withIdentifier: "goToNews", sender: nil)
    }
    
    @IBAction func unwindFromSecondView(_ sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindFromSignIn(_ sender: UIStoryboardSegue) {
        
    }
    
    override func segueForUnwinding(to toViewController: UIViewController, from fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue {
        if let id = identifier{
            if id == "idFirstSegueUnwind" {
                let unwindSegue = UnwindSegueFromLeft(identifier: id, source: fromViewController, destination: toViewController, performHandler: { () -> Void in
                    
                })
                return unwindSegue
            } else if id == "idUnwindFromSignIn" {
                let unwindSegue = UnwindSegueFromLeft(identifier: id, source: fromViewController, destination: toViewController, performHandler: { () -> Void in
                    
                })
                return unwindSegue
            }
        }
        
        return super.segueForUnwinding(to: toViewController, from: fromViewController, identifier: identifier)!
    }

}



