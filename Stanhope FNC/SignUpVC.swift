//
//  SignUpVC.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 5/3/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Foundation

class SignUpVC: UIViewController {
    
    @IBOutlet weak var someView: UIView!
    @IBOutlet weak var emailTextField: LargeTextField!
    
    var emailSet = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "idFirstSegueUnwind", sender: self)
    }
    
    @IBAction func unwindFromNameAndPasswordView(_ sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if emailTextField.text != nil {
            let email = emailTextField.text
            if validateEmail(enteredEmail: email!) {
                print("valid")
                self.emailSet = email!
                self.performSegue(withIdentifier: "nameAndPassword", sender: self)
            } else {
                print("not valid")
            }
        }
        
        
        
        
        //
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nameAndPassword" {
            let destinationVC = segue.destination as! NameAndPasswordVC
            destinationVC.email = self.emailSet
        }
    }
    
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    

}


