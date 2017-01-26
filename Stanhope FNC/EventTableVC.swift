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
        
        eventTableView.estimatedRowHeight = 230
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
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
            print(self.events)
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
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
