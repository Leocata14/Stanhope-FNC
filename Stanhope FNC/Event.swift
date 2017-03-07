//
//  Event.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 23/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import Foundation

class Event {
    
    private var _title: String!
    private var _date: String!
    private var _location: String!
    private var _description: String!
    private var _eventKey: String!
    private var _eventImageUrl: String?
    
    var eventKey: String {
        return _eventKey
    }
    
    var title: String {
        return _title
    }
    
    var date: String {
        return _date
    }
    
    var location: String {
        return _location
    }
    
    var description: String {
        return _description
    }
    
    var eventImageUrl: String? {
        return _eventImageUrl
    }
    
    init(eventKey: String, dictionary: Dictionary<String,AnyObject>) {
        self._eventKey = eventKey
        
        if let title = dictionary["eventTitle"] as? String {
            self._title = title
        }
        
        if let date = dictionary["eventDate"] as? String {
            self._date = date
        }
        if let location = dictionary["eventLocation"] as? String {
            self._location = location
        }
        if let description = dictionary["eventInfo"] as? String {
            self._description = description
        }
        
        if let imageUrl = dictionary["eventImgUrl"] as? String {
            self._eventImageUrl = imageUrl
        }
    }
    
}
