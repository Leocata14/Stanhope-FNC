//
//  LargeTextField.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 17/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit

class LargeTextField: UITextField {
    
    var bottomLine = CALayer()
    
    
    override func awakeFromNib() {
        //layer.cornerRadius = 5.0
        self.borderStyle = UITextBorderStyle.none
        self.layer.backgroundColor = UIColor.clear.cgColor
        
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 3.0, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = COLOUR_MAROON.cgColor
        
        self.layer.addSublayer(bottomLine)

        
    }
    
    //For placeholder
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        return bounds.insetBy(dx: 10, dy: 10)
        
    }
    
    //For editable text
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        return bounds.insetBy(dx: 10, dy: 10)
    }
    
}
