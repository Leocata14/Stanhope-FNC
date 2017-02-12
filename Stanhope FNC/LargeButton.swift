//
//  LargeButton.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 17/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit

class LargeButton: UIButton {
    
    override func awakeFromNib() {
        
        layer.cornerRadius = 5.0
        layer.opacity = 1.0
        //layer.shadowColor = UIColor(red: SHADOW_COLOUR, green: SHADOW_COLOUR, blue: SHADOW_COLOUR, alpha: 0.5).CGColor
        //layer.shadowOpacity = 0.8
        //layer.shadowRadius = 5.0
        //layer.shadowOffset = CGSizeMake(0.0, 2.0)
        
    }
    
    
    
}
