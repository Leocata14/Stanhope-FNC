//
//  Constants.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 17/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import Foundation
import UIKit

let KEY_UID = "uid"
var ADMIN_USER = false


//Segues
let SEGUE_LOGGED_IN = "loggedIn"
let SEGUE_GO_TO_LOGIN = "logIn"
let SEGUE_NEWS_DETAIL = "newsDetail"
let SEGUE_EVENT_DETAIL = "eventDetail"
let SEGUE_ABOUT = "goToAbout"
let SEGUE_FEEDBACK = "goToFeedback"
let SEGUE_LADDER = "showLadder"
let SEGUE_MATCHES = "showMatches"

//Status cODES
let STATUS_ACCOUNT_NONEXIST = 17011

//Colours
let COLOUR_ORANGE = UIColor(red: 255.0/255.0, green: 102.0/255.0, blue: 0.0/255.0, alpha: 1.0)
let COLOUR_GREEN = UIColor(red: 115.0/255.0, green: 191.0/255.0, blue: 32.0/255.0, alpha: 1.0)
let COLOUR_CHARCOAL = UIColor(red: 142.0/255.0, green: 142.0/255.0, blue: 142.0/255.0, alpha: 1.0)
let COLOUR_RED = "EA0F39"
let COLOUR_YELLOW = UIColor(red: 255.0/255.0, green: 204.0/255.0, blue: 1.0/255.0, alpha: 1.0)
let COLOUR_MAROON = UIColor(red: 93.0/255.0, green: 40.0/255.0, blue: 62.0/255.0, alpha: 1.0)
let COLOUR_DARK_MAROON = UIColor(red: 64.0/255.0, green: 27.0/255.0, blue: 42.0/255.0, alpha: 1.0)

//URLs
let URL_ABOUT = "http://stanhope-fnc-news.webflow.io/about"
let URL_FEEDBACK = "http://stanhope-fnc-news.webflow.io/feedback"

extension Date {
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone!
        return dateFormatter.string(from: self as Date)
    }
    var fullMonth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone!
        return dateFormatter.string(from: self as Date)
    }
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone!
        return dateFormatter.string(from: self as Date)
    }
    var hour0x: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone!
        return dateFormatter.string(from: self as Date)
    }
    var minute0x: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone!
        return dateFormatter.string(from: self as Date)
    }
    var hoursMinutes: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone!
        return dateFormatter.string(from: self as Date)
    }
}

func dateStringToNSDate(date: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM dd, yyyy, hh:mm a"
    dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone!
    let dateFromString = dateFormatter.date(from: date)
    return dateFromString! as Date
}

func newsDateStringToNSDate(date: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "eee, dd MMM yyy hh:mm:ss zzz"
    dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone!
    let dateFromString = dateFormatter.date(from: date)
    return dateFromString! as Date
}

func NewsDateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM dd, hh:mma"
    dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone!
    let stringFromDate = dateFormatter.string(from: date)
    return stringFromDate as String
}

func roundDateStringToNSDate(date: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM dd, yyyy"
    dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone!
    let dateFromString = dateFormatter.date(from: date)
    return dateFromString! as Date
}

func DateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM dd, yyyy, hh:mm"
    dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone!
    let stringFromDate = dateFormatter.string(from: date)
    return stringFromDate as String
}




extension CALayer {
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect.init(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect.init(x: 0, y: 0, width: thickness, height: frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect.init(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor
        
        self.addSublayer(border)
    }
}

extension Dictionary where Value: Equatable {
    func allKeys(forValue val: Value) -> [Key] {
        return self.filter { $1 == val }.map { $0.0 }
    }
}
