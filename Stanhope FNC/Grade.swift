//
//  Grade.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 21/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import Foundation

class Grade {
    private var _gradeKey: String?
    private var _name: String?
    private var _ladderUrl: String?
    private var _matches: Dictionary<String,AnyObject>?
    private var _shortName: String?
    
    var gradeKey: String? {
        return _gradeKey
    }
    
    var name: String? {
        return _name
    }
    
    var ladderUrl: String? {
        return _ladderUrl
    }
    
    var matches: Dictionary<String,AnyObject>? {
        return _matches
    }
    
    var shortName: String? {
        return _shortName
    }
    
    init(gradeKey: String, dictionary: Dictionary<String,AnyObject>) {
        self._gradeKey = gradeKey
        
        if let name = dictionary["name"] as? String {
            self._name = name
        }
        if let ladderUrl = dictionary["ladderUrl"] as? String {
            self._ladderUrl = ladderUrl
        }
        if let matches = dictionary["matches"] as! Dictionary<String,AnyObject>? {
            self._matches = matches
        }
        if let shortName = dictionary["shortName"] as? String {
            self._shortName = shortName
        }
        
    }
    
}
