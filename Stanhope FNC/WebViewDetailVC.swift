//
//  WebViewDetailVC.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 26/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit

class WebViewDetailVC: UIViewController, UIWebViewDelegate {

    var url = ""
    var viewTitle = ""
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    var theBool: Bool = false
    var myTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        print(url)
        webView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = viewTitle.uppercased()
        let url = NSURL(string: self.url)
        let requestObj = NSURLRequest(url: url! as URL)
        webView.loadRequest(requestObj as URLRequest)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        funcToCallWhenStartLoadingWebview()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        funcToCallCalledWhenUIWebViewFinishesLoading()
    }
    
    
    func funcToCallWhenStartLoadingWebview() {
        self.progressView.progress = 0.0
        self.theBool = false
        self.myTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(NewsDetailVC.timerCallback), userInfo: nil, repeats: true)
    }
    
    func funcToCallCalledWhenUIWebViewFinishesLoading() {
        self.theBool = true
    }
    
    func timerCallback() {
        if self.theBool {
            if self.progressView.progress >= 1 {
                self.progressView.isHidden = true
                self.myTimer.invalidate()
            } else {
                self.progressView.progress += 0.1
            }
        } else {
            self.progressView.progress += 0.05
            if self.progressView.progress >= 0.95 {
                self.progressView.progress = 0.95
            }
        }
    }

}
