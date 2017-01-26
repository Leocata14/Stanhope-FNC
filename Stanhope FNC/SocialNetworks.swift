//
//  SocialNetworks.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 23/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import Foundation
import UIKit

struct SocialNetworkUrl {
    let scheme: String
    let page: String
    
    func openPage() {
        let schemeUrl = NSURL(string: scheme)!
        if UIApplication.shared.canOpenURL(schemeUrl as URL) {
            UIApplication.shared.openURL(schemeUrl as URL)
        } else {
            UIApplication.shared.openURL(NSURL(string: page)! as URL)
        }
    }
}

enum SocialNetwork {
    case Facebook, Twitter, Instagram
    func url() -> SocialNetworkUrl {
        switch self {
        case .Facebook: return SocialNetworkUrl(scheme: "fb://profile/176761672460397", page: "http://facebook.com/StanhopeFootballNetballClub/")
        case .Twitter: return SocialNetworkUrl(scheme: "twitter:///user?screen_name=StanhopeFC", page: "https://twitter.com/StanhopeFC")
        case .Instagram: return SocialNetworkUrl(scheme: "instagram://camera", page: "https://instagram.com/Stanhope_FNC")
        }
    }
    func openPage() {
        self.url().openPage()
    }
}
