//
//  EventCell.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 23/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class EventCell: UITableViewCell {
    
    var event: Event!
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    
    @IBOutlet weak var eventDayLabel: UILabel!
    @IBOutlet weak var eventMonthLabel: UILabel!
    
    
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    
    let dateFormatter = DateFormatter()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView?.layer.cornerRadius = 5
        imageView?.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(event: Event, img: UIImage? = nil){
        
        
        
        self.event = event
        self.eventTitle.text = event.title.uppercased()
        self.eventLocationLabel.text = event.location.uppercased()
        
        let convertedDate = dateStringToNSDate(date: event.date)
        
        self.eventMonthLabel.text = convertedDate.month.uppercased()
        self.eventDayLabel.text = convertedDate.day
        self.eventTimeLabel.text = convertedDate.hoursMinutes
        
        if img != nil {
            self.eventImageView.image = img
        } else {
            if event.eventImageUrl == nil {
                
            } else {
                let ref = FIRStorage.storage().reference(forURL: event.eventImageUrl!)
                ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                    
                    if error != nil {
                        print("JASE: Unable to download image from Firebase Storage")
                    } else {
                        print("JASE: Image downloaded from Firebase")
                        //print(event.date)
                        if let imgData = data {
                            if let img  = UIImage(data: imgData) {
                                self.eventImageView.image = img
                                EventTableVC.imageCache.setObject(img, forKey: event.eventImageUrl as AnyObject)
                            }
                        }
                    }
                    
                })
            }
            
        }
        
        
    }
    
    
}
