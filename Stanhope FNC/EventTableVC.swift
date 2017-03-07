//
//  EventTableVC.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 23/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Firebase

class EventTableVC: UITableViewController {
    
    var events = [Event]()
    static var imageCache = NSCache<AnyObject, AnyObject>()

    @IBOutlet var eventTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
        
        eventTableView.estimatedRowHeight = 270

        
        DataService.ds.REF_EVENTS.observe(.value, with: { (snapshot) -> Void in
            
            self.events = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    if let eventsDict = snap.value as? Dictionary<String,AnyObject> {
                        let key = snap.key
                        let events = Event(eventKey: key, dictionary: eventsDict)
                        self.events.append(events)

                    }

                    
                }
                
            }
            //self.events = self.news.reversed()
            self.tableView.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = events[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventCell {
            if let img = EventTableVC.imageCache.object(forKey: event.eventImageUrl as AnyObject) as? UIImage {
                cell.configureCell(event: event, img: img)
                return cell
            } else {
                cell.configureCell(event: event)
                return cell
            }
        } else {
            return EventCell()
        }
    }


    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == SEGUE_EVENT_DETAIL {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! EventDetailTableVC
                
                destinationController.event = events[indexPath.row]
                if let img = EventTableVC.imageCache.object(forKey: events[indexPath.row].eventImageUrl as AnyObject) as? UIImage {
                    destinationController.img = img
                }
                
            }
        }
    }
    

}
