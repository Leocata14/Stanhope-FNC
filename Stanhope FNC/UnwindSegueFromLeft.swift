//
//  UnwindSegueFromLeft.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 6/3/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit

class UnwindSegueFromLeft: UIStoryboardSegue {
    
    override func perform() {
        var secondVCView = self.source.view as UIView!
        var firstVCView = self.destination.view as UIView!
        
        //let screenHeight = UIScreen.main.bounds.size.height
        let screenWidth = UIScreen.main.bounds.size.width
        
        // Specify the initial position of the destination view.
        //firstVCView?.frame = CGRect(x: -screenWidth, y: 0.0, width: screenWidth, height: screenHeight)
        
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(firstVCView!, aboveSubview: secondVCView!)
        
        // Animate the transition.
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            firstVCView?.frame = (firstVCView?.frame.offsetBy(dx: screenWidth/2, dy: 0.0))!
            secondVCView?.frame = (secondVCView?.frame.offsetBy(dx: screenWidth/2, dy: 0.0))!
            
        }) { (Finished) -> Void in
            
            self.source.dismiss(animated: false, completion: nil)
        }
    }

}
