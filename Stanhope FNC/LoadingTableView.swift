//
//  LoadingTableView.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 27/2/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import SwiftyGif

class LoadingTableView: UITableView {
    //let imageData = NSData(contentsOf: Bundle.main.url(forResource: "loader", withExtension: "gif")!)
    
    let gifmanager = SwiftyGifManager(memoryLimit:20)
    let loadingImage = UIImage(named: "loader")
    var loadingImageView: UIImageView
    
    
    required init(coder aDecoder: NSCoder) {
        //loadingImageView = UIImageView(image: loadingImage)
        loadingImageView = UIImageView(gifImage: loadingImage!, manager: gifmanager)
        super.init(coder: aDecoder)!
        addSubview(loadingImageView)
        adjustSizeOfLoadingIndicator()
    }
    
    func showLoadingIndicator() {
        print("Animating!")
        loadingImageView.isHidden = false
        self.bringSubview(toFront: loadingImageView)
        
        startRefreshing()
    }
    
    func hideLoadingIdicator() {
        print("Not animating anymore!")
        loadingImageView.isHidden = true
        
        stopRefreshing()
    }
    
    override func reloadData() {
        super.reloadData()
        self.bringSubview(toFront: loadingImageView)
    }
    
    //MARK: Private Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        adjustSizeOfLoadingIndicator()
    }
    
    private func adjustSizeOfLoadingIndicator() {
        let loadingImageSize = loadingImage?.size
        loadingImageView.frame = CGRect(x: frame.width/2 - (loadingImageSize?.width)!/2, y: frame.height/2-(loadingImageSize?.height)!/2, width: (loadingImageSize?.width)!, height: (loadingImageSize?.height)!)
    }
    
    //
    private func startRefreshing() {
        //let gif = UIImage.gif(name: "loader")
//        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
//        animation.isRemovedOnCompletion = false
//        animation.toValue = M_PI * 2.0
//        animation.duration = 0.8
//        animation.isCumulative = true
//        animation.repeatCount = Float.infinity
//        loadingImageView.layer.add(animation, forKey: "rotationAnimation")
    }

    private func stopRefreshing() {
        loadingImageView.layer.removeAllAnimations()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
