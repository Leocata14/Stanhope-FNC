//
//  NameAndPasswordVC.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 6/3/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftKeychainWrapper

class NameAndPasswordVC: UIViewController {
    
    var email = ""
    
    @IBOutlet weak var fullNameTextField: LargeTextField!
    @IBOutlet weak var passwordTextField: LargeTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(email)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindFromNameAndPassword", sender: self)
    }
    
    @IBAction func SignUpTapped(_ sender: Any) {
        if let name = fullNameTextField.text, let pwd = passwordTextField.text {
            FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                if error != nil {
                    print("JASE: Something went wrong. Unable to create user with Email")
                } else {
                    print("JASE: Successfully authenticated with Firebase/Email")
                    //Save to Firebase here
                    let uservalues = ["email":user?.email,"provider":"Email","fullName":name]
                    let uid = user?.uid
                    DataService.ds.REF_USERS.child(uid!).updateChildValues(uservalues, withCompletionBlock: { (error, ref) in
                        if error != nil {
                            //Something wrong
                            print(error)
                        } else {
                            print("JASE: Saved to Firbase Database!")
                        }
                    })
                    
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                }
            })
        } else {
            print("Email or Password not entered")
        }
    }
    
    func completeSignIn(id: String) {
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("JASE: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "signUpGoToNews", sender: nil)
    }
    


}
