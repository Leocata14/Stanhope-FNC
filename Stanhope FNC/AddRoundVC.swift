//
//  AddRoundVC.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 13/2/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Eureka

class AddRoundVC: FormViewController {
    
    var roundKey = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if roundKey == "" {
            self.title = "ADD ROUND"
        } else {
            self.title = "EDIT ROUND"
        }
        
       

        // Do any additional setup after loading the view.
        form +++ Section("Round Details")
            <<< TextRow() { row in
                row.title = "Season"
                row.placeholder = "2017"
                row.tag = "season"
                row.validate()
                
            }
            <<< IntRow() { row in
                row.title = "Round"
                row.placeholder = "Round"
                row.tag = "round"
                row.validate()
            }
            <<< ActionSheetRow<String>() {
                $0.title = "Played At"
                $0.options = PLAYED_AT
                $0.value = "Home"    // initially selected
                $0.tag = "playedAt"
                $0.validate()
            }

            <<< DateRow(){
                $0.title = "Date"
                $0.value = Date(timeIntervalSinceNow: 0)
                $0.tag = "date"
                $0.validate()
            }
            
            <<< PickerInlineRow<String>(){ row in
                row.title = "Opposition"
                row.options = OPPOSITION_TEAMS
                row.tag = "opposition"
                row.validate()
        
            }
        
            <<< ActionSheetRow<String>() {
                $0.title = "Status"
                $0.options = ROUND_STATUS
                $0.value = "Upcoming"    // initially selected
                $0.tag = "status"
                $0.validate()
        }
        
        
        
        
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        getAllFormData()
        

    }
    
    func getAllFormData() {
        let seasonRow = form.rowBy(tag: "season")
        let season = seasonRow?.baseValue
        
        let roundRow = form.rowBy(tag: "round")
        let round = roundRow?.baseValue
        
        let playedAtRow = form.rowBy(tag: "playedAt")
        let playedAt = playedAtRow?.baseValue
        
        let dateRow = form.rowBy(tag: "date")
        let date = dateRow?.baseValue as? Date
        let convertedDate = RoundDateToString(date: date!)
        
        let oppositionRow = form.rowBy(tag: "opposition")
        let opposition = oppositionRow?.baseValue
        
        let statusRow = form.rowBy(tag: "status")
        let status = statusRow?.baseValue
        
        
        let roundDict = ["season": season!,
                     "round": round!,
                     "playedAt": playedAt!,
                     "date": convertedDate,
                     "opposition": opposition!,
                     "status": status!
        ]
        print(roundDict)
        
        DataService.ds.REF_ROUNDS.childByAutoId().updateChildValues(roundDict) { (error, ref) in
            if error != nil {
                //Something wrong
                print(error!)
            } else {
                print("JASE: Saved to Firbase Database!")
            }
        }
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
