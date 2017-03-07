//
//  AddMatchVC.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 14/2/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Eureka
import UserNotifications

class AddMatchVC: FormViewController {
    
    var match: Match?
    var roundKey: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if match == nil {
            self.title = "ADD MATCH"
        } else {
            self.title = "EDIT MATCH"
        }
        
        
        form +++ Section("Match Details")
            
            <<< PickerInlineRow<String>(){ row in
                row.title = "Grade"
                row.options = GRADES
                row.tag = "grade"
                if match != nil {
                    row.value = match?.grade
                }
            }
        
            <<< TextRow() { row in
                row.title = "Stanhope Score"
                row.tag = "stanhopeScore"
                if match != nil {
                    row.value = match?.stanhopeScore
                }
            }
        
            <<< TextRow() { row in
                row.title = "Opposition Score"
                row.tag = "oppositionScore"
                if match != nil {
                    row.value = match?.oppositionScore
                }
            }

    }


    @IBAction func saveButtonTapped(_ sender: Any) {
        getAllFormData()
    }
    
    func getAllFormData() {
        let gradeRow = form.rowBy(tag: "grade")
        let grade = gradeRow?.baseValue
        
        let stanhopeScoreRow = form.rowBy(tag: "stanhopeScore")
        let stanhopeScore = stanhopeScoreRow?.baseValue
        
        let oppositionScoreRow = form.rowBy(tag: "oppositionScore")
        let oppositionScore = oppositionScoreRow?.baseValue
        
        //let selectedGrade = grade as? String
        let sortIndex = GRADES.index(of: "\(grade!)")
        
        let matchDict = ["\(self.roundKey!)": "true",
                         "sort": sortIndex,
                         "grade": grade!,
                         "stanhopeScore": stanhopeScore!,
                         "oppositionScore": oppositionScore!
                        ]
        
        if (self.match != nil) {
            DataService.ds.REF_MATCHES.child((self.match?.matchKey)!).updateChildValues(matchDict) { (error, ref) in
                if error != nil {
                    //Something wrong
                    print(error!)
                } else {
                    print("JASE: Saved to Firbase Database!")
                    DataService.ds.REF_ROUNDS.child(self.roundKey!).child("matches").updateChildValues([ref.key:"true"])
                    
                    
                    
                    let alert = UIAlertController(title: "Match Saved!", message: "The match details have been saved to the database", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                        
                        
                        
                        self.performSegue(withIdentifier: "unwindToRoundDetail", sender: self)
                        
                        
                    })
                    
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
        } else {
            //Make a new round
            DataService.ds.REF_MATCHES.childByAutoId().updateChildValues(matchDict) { (error, ref) in
                if error != nil {
                    //Something wrong
                    print(error!)
                } else {
                    print("JASE: Saved to Firbase Database!")
                    DataService.ds.REF_ROUNDS.child(self.roundKey!).child("matches").updateChildValues([ref.key:"true"])
                    
                    let alert = UIAlertController(title: "Match Saved!", message: "The match details have been saved to the database", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                        self.performSegue(withIdentifier: "unwindToRoundDetail", sender: self)
                    })
                    
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
