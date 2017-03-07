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
    
    var tappedMatch: Match?
    
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
        
        getMatches()
        
        
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func getMatches(){
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
                //Send Notifcation
                /*
                self.scheduleNotification(inSeconds: 5, grade: matchDict["grade"] as! String, stanScore: matchDict["stanhopeScore"] as! String, oppScore: matchDict["oppositionScore"] as! String, completion: { success in
                    if success {
                        print("Successfully schedule notification")
                    } else {
                        print("Error scheduling notification")
                    }
                })*/
            }
            
            self.matchesTableView.reloadData()
        })
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
    
    @IBAction func addButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: SEGUE_EDIT_MATCH, sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMatches()
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            self.tappedMatch = self.matches[indexPath.row]
            self.performSegue(withIdentifier: SEGUE_EDIT_MATCH, sender: nil)
        }
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
           let matchKey = self.matches[indexPath.row].matchKey
            DataService.ds.REF_MATCHES.child(matchKey).removeValue()
            DataService.ds.REF_ROUNDS.child(self.round.roundKey).child("matches").child(matchKey).removeValue()
        }
        edit.backgroundColor = UIColor.orange
        delete.backgroundColor = UIColor.red
        
        
        return [delete, edit]
    }
    
    @IBAction func unwindToRoundDetail(segue: UIStoryboardSegue) {}


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == SEGUE_EDIT_MATCH {
            let destinationVC = segue.destination as! AddMatchVC
            
            destinationVC.roundKey = self.round.roundKey
            
            if let barButton = sender as? UIBarButtonItem {
                destinationVC.match = nil
                
            } else {
                destinationVC.match = tappedMatch
                
            }
        }
    }
    
    /*
    func scheduleNotification(inSeconds: TimeInterval, grade: String,stanScore: String,oppScore:String, completion: @escaping (_ Success: Bool) -> ()) {
        let notif = UNMutableNotificationContent()
        notif.title = "Match Complete"
        notif.subtitle = "\(grade)"
        notif.body = "Stanhope: \(stanScore); oppositionScore: \(oppScore)"
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let notifRequest = UNNotificationRequest(identifier: "matchComplete", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(notifRequest, withCompletionHandler: { error in
            if error != nil {
                print(error)
                completion(false)
            } else {
                completion(true)
            }
            
        })
    }*/
    

}
