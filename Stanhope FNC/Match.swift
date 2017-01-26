//
//  Match.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 21/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import Foundation
import Firebase

class Match {
    private var _matchKey: String!
    private var _stanhopeScore: String?
    private var _oppositionScore: String?
    private var _grade: String?
    private var _sort: Int?
    
    var matchKey: String {
        return _matchKey
    }
    
    var stanhopeScore: String? {
        return _stanhopeScore
    }
    var oppositionScore: String?{
        return _oppositionScore
    }
    var grade: String? {
        return _grade
    }
    
    var sort: Int? {
        return _sort
    }
    
    
    init(matchKey: String, dicitionary: Dictionary<String,AnyObject>){
        self._matchKey = matchKey
        
        if let stanhopeScore = dicitionary["stanhopeScore"] as? String {
            self._stanhopeScore = stanhopeScore
        }
        if let oppositionScore = dicitionary["oppositionScore"] as? String {
            self._oppositionScore = oppositionScore
        }
        if let grade = dicitionary["grade"] as? String {
            self._grade = grade
        }
        if let sort = dicitionary["sort"] as? Int {
            self._sort = sort
        }
        
        
        
    }
    
    
}
