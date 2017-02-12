//
//  LadderCollectionViewCell.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 27/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit

@IBDesignable
class LadderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        //self.layer.addBorder(edge: .top, color: .gray, thickness: 1.0)
        self.layer.backgroundColor = UIColor.white.cgColor
        //print("JASE: Setting up cell, adding borders")
    }
    
}
