//
//  MoreTableVC.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 23/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftKeychainWrapper

class MoreTableVC: UITableViewController {
    
    @IBOutlet var moreTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                print("ABOUT")
                //performSegue(withIdentifier: SEGUE_ABOUT, sender: nil)
            }
            if indexPath.row == 1 {
                print("CONTACTS")
            }
            if indexPath.row == 2 {
                print("FEEDBACK")
                //performSegue(withIdentifier: SEGUE_FEEDBACK, sender: nil)
            }
        case 1:
            if indexPath.row == 0 {
                print("FACEBOOK")
                SocialNetwork.Facebook.openPage()
            }
            if indexPath.row == 1 {
                print("TWITTER")
                SocialNetwork.Twitter.openPage()
            }
            if indexPath.row == 2 {
                print("INSTA")
                SocialNetwork.Instagram.openPage()
            }
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }


    @IBAction func signOutTapped(_ sender: Any) {
        print("JASE: Sign Out Tapped")
        
        let optionMenu = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        
        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { (alert) in
            let firebaseAuth = FIRAuth.auth()
            let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
            
            do {
                try firebaseAuth?.signOut()
                
                self.performSegue(withIdentifier: "goToSignIn", sender: nil)
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
            print("Sign out")
            self.checkForLoggedIn()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
            print("Sign Out cancelled")
        }
        
        optionMenu.addAction(signOutAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func checkForLoggedIn() {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("ID FOUND IN KEYCHAIN")
            //performSegue(withIdentifier: "goToNews", sender: nil)
        } else {
            print("NUH UHHHHHH")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_ABOUT {
            let destinationVC = segue.destination as! WebViewDetailVC
            destinationVC.url = URL_ABOUT
            destinationVC.viewTitle = "ABOUT"
        }
        
        if segue.identifier == SEGUE_FEEDBACK {
            let destinationVC = segue.destination as! WebViewDetailVC
            destinationVC.url = URL_FEEDBACK
            destinationVC.viewTitle = "FEEDBACK"
        }
    }

}
