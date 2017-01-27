//
//  Final.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 26/01/2017.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import Foundation
import Firebase

class FinalMatch {
    private var _finalKey: String!
    private var _opposition: String?
    private var _date: String?
    private var _stanhopeScore: String?
    private var _oppositionScore: String?
    private var _playedAt: String?
    private var _status: String?
    
    var finalKey: String {
        return _finalKey
    }
    var opposition: String {
        return _opposition!
    }
    var stanhopeScore: String {
        return _stanhopeScore!
    }
    var oppositionScore: String {
        return _oppositionScore!
    }
    var playedAt: String {
        return _playedAt!
    }
    var date: String {
        return _date!
    }
    var status: String {
        return _status!
    }
    
    init(finalKey: String, dictionary: Dictionary<String,AnyObject>) {
        self._finalKey = finalKey
        
        if let opposition = dictionary["opposition"] as? String {
            self._opposition = opposition
        }
        if let stanhopeScore = dictionary["stanhopeScore"] as? String {
            self._stanhopeScore = stanhopeScore
        }
        if let oppositionScore = dictionary["oppositionScore"] as? String {
            self._oppositionScore = oppositionScore
        }
        if let playedAt = dictionary["playedAt"] as? String {
            self._playedAt = playedAt
        }
        if let date = dictionary["date"] as? String {
            self._date = date
        }
        if let status = dictionary["status"] as? String {
            self._status = status
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
