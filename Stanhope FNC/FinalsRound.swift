//
//  FinalsRound.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 26/01/2017.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import Foundation
import Firebase

class FinalsRound {
    
    private var _finalsRoundKey: String!
    private var _name: String!
    private var _week: Int!
    private var _finalsMatches: Dictionary<String,AnyObject>?
    
    var finalsRoundKey: String {
        return _finalsRoundKey
    }
    var name: String {
        return _name
    }
    var week: Int {
        return _week
    }
    var finalsMatches: Dictionary<String,AnyObject>? {
        return _finalsMatches
    }
    
    init(finalsRoundKey: String, dictionary: Dictionary<String,AnyObject>) {
        self._finalsRoundKey = finalsRoundKey
        
        if let name = dictionary["name"] as? String {
            self._name = name
        }
        if let week = dictionary["week"] as? Int {
            self._week = week
        }
        if let finalsMatches = dictionary["finalsMatches"] as? Dictionary<String,AnyObject> {
            self._finalsMatches = finalsMatches
        }
    }
    
    
}
