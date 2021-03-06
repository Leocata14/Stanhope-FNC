//
//  RoundsTableVC.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 19/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Firebase
import XMSegmentedControl


class RoundsTableVC: UIViewController, UITableViewDataSource,UITableViewDelegate, XMSegmentedControlDelegate {
    
    var rounds = [Round]()
    var currRound: Round?
    
    var finalsRounds = [FinalsRound]()
    
    
    var selectedIndex = 0
    
     @IBOutlet weak var roundsTableView: UITableView!
    //@IBOutlet weak var roundsSegmentedControl: XMSegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundsTableView.delegate = self
        roundsTableView.dataSource = self
        
        roundsTableView.estimatedRowHeight = 120
        
        let roundsSegementedControl = XMSegmentedControl(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44), segmentTitle: ["HOME & AWAY", "FINALS"], selectedItemHighlightStyle: XMSelectedItemHighlightStyle.bottomEdge)
        roundsSegementedControl.delegate = self
        
        roundsSegementedControl.backgroundColor = COLOUR_DARK_MAROON
        roundsSegementedControl.highlightColor = COLOUR_YELLOW
        roundsSegementedControl.tint = UIColor.white
        roundsSegementedControl.highlightTint = COLOUR_YELLOW
        roundsSegementedControl.font = UIFont(name: "Dosis-SemiBold", size: 14.0)!
        
        self.view.addSubview(roundsSegementedControl)
        
        xmSegmentedControl(roundsSegementedControl, selectedSegment: 0)
        
        getFinals()
        
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
    
    func xmSegmentedControl(_ xmSegmentedControl: XMSegmentedControl, selectedSegment: Int) {
        print("SegmentedControl Selected Segment: \(selectedSegment)")
        if selectedSegment == 0 {
            self.selectedIndex = 0
        } else if selectedSegment == 1 {
            self.selectedIndex = 1
            DataService.ds.REF_FINALS_MATCHES.observe(.value, with: { (snapshot) -> Void in
                self.finalsRounds = []
                if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    for snap in snapshots {
                        //print("JASE: FINALS SNAP \(snap)")
                    }
                }
            })
        }
    }
    
    func getFinals() {
        print("JASE: GETTING FINALS")
        DataService.ds.REF_FINALS_ROUNDS.observe(.value, with: { (snapshot) -> Void in
            self.finalsRounds = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    print("JASE: FINALS ROUNDS \(snap)")
                    if let roundsDict = snap.value as? Dictionary<String,AnyObject> {
                        let key = snap.key
                        let final = FinalsRound(finalsRoundKey: key, dictionary: roundsDict)
                        self.finalsRounds.append(final)
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

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if self.selectedIndex == 0 {
            return 1
        } else {
            return finalsRounds.count
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rounds.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let round = rounds[indexPath.row]
        
        if self.selectedIndex == 0 {
            
        } else if self.selectedIndex == 1 {
            
        }
        
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
