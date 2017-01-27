//
//  RoundDetailTableVC.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 21/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RoundDetailTableVC: UITableViewController {
    
    var round: Round!
    var matches = [Match]()
    var roundMatches: Dictionary<String,AnyObject> = [:]
    var matchKeys: Array = [""]
    
    @IBOutlet weak var matchesTableView: UITableView!
    @IBOutlet weak var stanImageView: UIImageView!
    @IBOutlet weak var oppositionImageView: UIImageView!
    @IBOutlet weak var roundStatusLabel: UILabel!
    @IBOutlet weak var roundDateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.matchesTableView.delegate = self
        self.matchesTableView.dataSource = self
        
        setUpUi()
        

        
        DataService.ds.REF_MATCHES.observe(.value, with: { (snapshot) -> Void in
            print("matches changed")
            self.matches = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    if self.matchKeys.contains(snap.key) {
                        if let matchDict = snap.value as? Dictionary<String,AnyObject> {
                            print("JASE: \(matchDict)")
                            let key = snap.key
                            
                            let match = Match(matchKey: key, dicitionary: matchDict)
                            self.matches.append(match)
                            self.matches.sort(by: {$0.sort! < $1.sort!})
                        }
                        
                    }
                    
                }
            }
            
            self.matchesTableView.reloadData()
        })
        
        
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func setUpUi() {
        let viewTitle = "Round \(round.round!)"
        self.title = viewTitle.uppercased()
        
        self.stanImageView.image = UIImage(named: "Stanhope")
        self.oppositionImageView.image = UIImage(named: "\(round.opposition!)")
        self.roundStatusLabel.text = round.status?.uppercased()
        
        let roundDate = roundDateStringToNSDate(date: round.date!)
        
        self.roundDateLabel.text = "\(roundDate.fullMonth + " " + roundDate.day)"
        
        if round.status == "Upcoming" {
            roundStatusLabel.textColor = COLOUR_ORANGE
        }
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        if round.matches != nil {
            if let matches = round.matches! as? Dictionary<String,AnyObject> {
                for match in matches {
                    print(match)
                    let matchKey = match.0
                    self.matchKeys.append(matchKey)
                }
            }
        } else {
            print("no matches")
        }

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
        return matches.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let match = matches[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "match") as? MatchCell {
            cell.configureMatchCell(match: match)
            return cell
        } else {
            return MatchCell()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
