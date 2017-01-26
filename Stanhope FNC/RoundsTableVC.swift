//
//  RoundsTableVC.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 19/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Firebase

class RoundsTableVC: UITableViewController {
    
    var rounds = [Round]()
    var currRound: Round?
    
     @IBOutlet weak var roundsTableView: UITableView!
    //@IBOutlet weak var roundsSegmentedControl: XMSegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundsTableView.delegate = self
        roundsTableView.dataSource = self
        
        roundsTableView.estimatedRowHeight = 120
        
        DataService.ds.REF_ROUNDS.observe(.value, with: { (snapshot) -> Void in
            
            self.rounds = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    print("SNAP: \(snap)")
                    if let roundsDict = snap.value as? Dictionary<String,AnyObject> {
                        if let season = roundsDict["season"] {
                            if season as! String == "2017" {
                                //print("GOT HERE")
                                let key = snap.key
                                let round = Round(roundKey: key, dictionary: roundsDict)
                                self.rounds.append(round)
                                self.rounds.sort(by: {$0.round! < $1.round! })
                            }
                        }
                    }
                }
            }
            self.roundsTableView.reloadData()
            
            
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
        return rounds.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let round = rounds[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "roundCell") as? RoundCell {
            cell.configureRoundCell(round: round)
            return cell
        } else {
            return RoundCell()
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "roundDetail" {
            if let indexPath = roundsTableView.indexPathForSelectedRow {
                let destinationVC = segue.destination as! RoundDetailTableVC
                
                let tappedRound = rounds[indexPath.row]
                destinationVC.round = tappedRound
            }
        }
    }
    

}
