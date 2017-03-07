//
//  AddEvent.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 3/3/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Eureka

class AddEventVC: FormViewController {
    
    var event: Event?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if event == nil {
            self.title = "ADD EVENT"
        } else {
            self.title = "EDIT EVENT"
        }
        
        form +++ Section("Event Details")
            
            <<< TextRow() { row in
                row.title = "Title"
                row.placeholder = "Title"
                row.tag = "title"
                if event != nil {
                    row.value = event?.title
                }
            }
            
            <<< DateTimeRow(){
                $0.title = "Date"
                if event != nil {
                    
                    let convertDate = dateStringToNSDate(date: (event?.date)!)
                    $0.value = convertDate
                } else {
                    $0.value = Date(timeIntervalSinceNow: 0)
                }
                $0.tag = "date"
                
            }

        
            <<< TextRow() { row in
                row.title = "Location"
                row.placeholder = "Location"
                row.tag = "location"
                if event != nil {
                    row.value = event?.location
                }
            }
            
            
            <<< TextAreaRow() { row in
                row.title = "Description"
                row.placeholder = "Description"
                row.tag = "description"
                if event != nil {
                    row.value = event?.description
                }
            }
        
            <<< ImageRow(){ row in
                row.title = "Event Image"
                row.tag = "image"
                
        }
        
        
        
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        getAllFormData()
    }
    
    func getAllFormData() {
        let titleRow = form.rowBy(tag: "title")
        let title = titleRow?.baseValue
        
        let dateRow = form.rowBy(tag: "date")
        let date = dateRow?.baseValue as? Date
        let convertedDate = eventDateToString(date: date!)
        
        let locationRow = form.rowBy(tag: "location")
        let location = locationRow?.baseValue
        
        let descriptionRow = form.rowBy(tag: "description")
        let description = descriptionRow?.baseValue
        
        let eventDict = ["eventTitle": title,
                         "eventDate":convertedDate,
                         "eventLocation":location,
                         "eventInfo":description
        ]
        
        print(eventDict)
        
        if self.event != nil {
            
        } else {
            //Make a new event
            DataService.ds.REF_EVENTS.childByAutoId().updateChildValues(eventDict, withCompletionBlock: { (error, ref) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    print("JASE: Saved to Firebase")
                }
            })
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
