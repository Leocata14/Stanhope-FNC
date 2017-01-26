//
//  Round.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 19/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import Foundation

class Round {
    
    private var _roundKey: String!
    //private var _name: String?
    private var _opposition: String?
    private var _status: String?
    private var _playedAt: String?
    private var _date: String?
    private var _round: Int?
    private var _matches: Dictionary<String,AnyObject>?
    
    
    var roundKey: String {
        return _roundKey
    }

    var opposition: String? {
        return _opposition
    }
    var status: String? {
        return _status
    }
    var playedAt: String? {
        return _playedAt
    }
    var date: String? {
        return _date
    }
    var round: Int? {
        return _round
    }
    var  matches: Dictionary<String,AnyObject>? {
        return _matches
    }
    
    init(roundKey: String, dictionary: Dictionary<String,AnyObject>) {
        self._roundKey = roundKey
        
        if let opposition = dictionary["opposition"] as? String {
            self._opposition = opposition
        }
        if let status = dictionary["status"] as? String {
            self._status = status
            
        }
        if let playedAt = dictionary["playedAt"] as? String {
            self._playedAt = playedAt
        }
        if let date = dictionary["date"] as? String {
            self._date = date
        }
        if let round = dictionary["round"] as? Int {
            self._round = round
        }
        if let matches = dictionary["matches"] as? Dictionary<String,AnyObject> {
            self._matches = matches
        }
        
        
        
    }
    
    
    
}
