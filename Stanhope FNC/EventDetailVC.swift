//
//  EventDetailVC.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 26/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class EventDetailVC: UIViewController {
    
    var img: UIImage?

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventMonthLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    
    var event: Event!
    static var imageCache = NSCache<AnyObject, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = event.title.uppercased()
        
        eventTitleLabel.text = event.title.uppercased()
        eventLocationLabel.text = event.location.uppercased()
        
        let convertedDate = dateStringToNSDate(date: event.date)
        
        eventMonthLabel.text = convertedDate.month.uppercased()
        eventDateLabel.text = convertedDate.day
        eventTimeLabel.text = convertedDate.hoursMinutes
        
        eventImageView.image = img
        
    }
    
    func setUpUI(event: Event) {
        
    }

}
