//
//  LoaderOverlay.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 11/2/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import Foundation
import UIKit

public class LoaderOverlay {
    private var loaderOverlayView: UIView!
    
    class var shared: LoaderOverlay {
        struct Static {
            static let instance: LoaderOverlay = LoaderOverlay()
        }
        return Static.instance
    }
    
    private func setup() {
        loaderOverlayView = UIView(frame: CGRect(x: 0, y: 0, width: 110, height: 100))
        loaderOverlayView.backgroundColor = UIColor.black
        loaderOverlayView.alpha = 0.8
        loaderOverlayView.layer.cornerRadius = 8
        
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .white)
        indicator.tag = 1
        loaderOverlayView.addSubview(indicator)
        indicator.center = CGPoint(x: loaderOverlayView.frame.width/2.0, y: loaderOverlayView.frame.height/2.0)
        indicator.startAnimating()
    }
    
    //MARK:- Public
    public func show() {
        if loaderOverlayView == nil {
            self.setup()
        } else {
            let indictor = loaderOverlayView.viewWithTag(1) as! UIActivityIndicatorView
            indictor.startAnimating()
        }
        
        if let window = UIApplication.shared.delegate?.window {
            window?.addSubview(loaderOverlayView)
            loaderOverlayView.center = window!.center
        }
        
        
    }
    
    public func hide() {
        let indictor = loaderOverlayView.viewWithTag(1) as! UIActivityIndicatorView
        indictor.stopAnimating()
        
        loaderOverlayView.removeFromSuperview()
    }
    
}
