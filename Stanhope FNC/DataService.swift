//
//  DataService.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 17/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper


let URL_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()


class DataService {
    static let ds = DataService()
    
    //Database References
    private var _REF_BASE = URL_BASE
    private var _REF_USERS = URL_BASE.child("users")
    private var _REF_NEWS = URL_BASE.child("news")
    private var _REF_ROUNDS = URL_BASE.child("rounds")
    private var _REF_ROUNDS_MATCHES = URL_BASE.child("rounds/matches")
    private var _REF_MATCHES = URL_BASE.child("matches")
    private var _REF_GRADES = URL_BASE.child("grade")
    private var _REF_EVENTS = URL_BASE.child("events")
    private var _REF_FINALS_MATCHES = URL_BASE.child("finalsMatches")
    private var _REF_FINALS_ROUNDS = URL_BASE.child("finalTypes")
    
    private var _REF_CONFIG = URL_BASE.child("config")
    
    //Storage References
    private var _REF_STORAGE_BASE = STORAGE_BASE
    private var _REF_STORAGE_EVENTS = STORAGE_BASE.child("events")
    
    var REF_STORAGE_EVENTS: FIRStorageReference {
        return _REF_STORAGE_EVENTS
    }
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_NEWS: FIRDatabaseReference {
        return _REF_NEWS
    }
    
    var REF_ROUNDS: FIRDatabaseReference {
        return _REF_ROUNDS
    }
    var REF_ROUNDS_MATCHES: FIRDatabaseReference {
        return _REF_ROUNDS_MATCHES
    }
    
    var REF_MATCHES: FIRDatabaseReference {
        return _REF_MATCHES
    }
    
    var REF_GRADES: FIRDatabaseReference {
        return _REF_GRADES
    }
    
    var REF_EVENTS: FIRDatabaseReference {
        return _REF_EVENTS
    }
    
    var REF_FINALS_MATCHES: FIRDatabaseReference {
        return _REF_FINALS_MATCHES
    }
    
    var REF_FINALS_ROUNDS: FIRDatabaseReference {
        return _REF_FINALS_ROUNDS
    }
    
    var REF_CONFIG: FIRDatabaseReference {
        return _REF_CONFIG
    }
    
    var REF_USER_CURRENT: FIRDatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = URL_BASE.child("users").child(uid!)
        return user
        
    }
    
    func createFirebaseUsers(userData: Dictionary<String, String>){
        // Ensure the user has a uid before attempting to save their data.
        if (UserDefaults.standard.value(forKey: KEY_UID) != nil) {
            REF_USER_CURRENT.updateChildValues(userData)
        }
    }
    
    func checkAdminUser(){
        if let userId = FIRAuth.auth()?.currentUser?.uid {
            REF_USERS.child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                let userDict = snapshot.value as? [String: AnyObject] ?? [:]
                if let role = userDict["role"] as? String {
                    if role == "admin" {
                        print("We have an admin user here guys!")
                        ADMIN_USER = true
                    } else {
                        print("Just a regular user here peeps")
                        ADMIN_USER = false
                    }
                }
                
            })
        } else {
            ADMIN_USER = false
        }
        
        
    }
}
