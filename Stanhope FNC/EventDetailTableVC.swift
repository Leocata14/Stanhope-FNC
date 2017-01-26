//
//  EventDetailTableVC.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 26/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import FirebaseStorage

class EventDetailTableVC: UITableViewController {
    
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

        self.title = event.title.uppercased()
        
        eventTitleLabel.text = event.title.uppercased()
        eventLocationLabel.text = event.location.uppercased()
        eventDescriptionLabel.text = event.description
        eventDescriptionLabel.sizeToFit()
        
        print(eventDescriptionLabel.frame.height)
        
        
        let convertedDate = dateStringToNSDate(date: event.date)
        
        eventMonthLabel.text = convertedDate.month.uppercased()
        eventDateLabel.text = convertedDate.day
        eventTimeLabel.text = convertedDate.hoursMinutes
        
        eventImageView.image = img
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
