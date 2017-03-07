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

    var round: Round?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if round == nil {
            self.title = "ADD ROUND"
        } else {
            self.title = "EDIT ROUND"
        }
        
       

        // Do any additional setup after loading the view.
        form +++ Section("Round Details")

            <<< IntRow() { row in
                row.title = "Round"
                row.placeholder = "Round"
                row.tag = "round"
                if round != nil {
                    row.value = round?.round
                }
            }
            <<< ActionSheetRow<String>() {
                $0.title = "Played At"
                $0.options = PLAYED_AT
                if round != nil {
                    $0.value = round?.playedAt
                } else {
                    $0.value = "Home"
                }
                $0.tag = "playedAt"
            }

            <<< DateRow(){
                $0.title = "Date"
                if round != nil {
                    let convertDate = roundDateStringToNSDate(date: (round?.date)!)
                    $0.value = convertDate
                } else {
                    $0.value = Date(timeIntervalSinceNow: 0)
                }
                $0.tag = "date"
                
            }
            
            <<< PickerInlineRow<String>(){ row in
                row.title = "Opposition"
                row.options = OPPOSITION_TEAMS
                row.tag = "opposition"
                if round != nil {
                    row.value = round?.opposition
                }
        
            }
        
            <<< ActionSheetRow<String>() {
                $0.title = "Status"
                $0.options = ROUND_STATUS
                if round != nil {
                    $0.value = round?.status
                } else {
                    $0.value = "Upcoming"
                }
                $0.tag = "status"
        }
        
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Going, going gone....")
        self.round = nil
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
        
        
        let roundDict = ["season": "2017",
                     "round": round!,
                     "playedAt": playedAt!,
                     "date": convertedDate,
                     "opposition": opposition!,
                     "status": status!
        ]
        print(roundDict)
        
        if (self.round != nil) {
            DataService.ds.REF_ROUNDS.child((self.round?.roundKey)!).updateChildValues(roundDict) { (error, ref) in
                if error != nil {
                    //Something wrong
                    print(error!)
                } else {
                    print("JASE: Saved to Firbase Database!")
                }
            }
        } else {
            //Make a new round
            DataService.ds.REF_ROUNDS.childByAutoId().updateChildValues(roundDict) { (error, ref) in
                if error != nil {
                    //Something wrong
                    print(error!)
                } else {
                    print("JASE: Saved to Firbase Database!")
                }
            }
        }
        
        
        
    }


}
