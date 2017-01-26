//
//  LaddersVC.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 21/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Firebase
import XMSegmentedControl

class LaddersVC: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    var grades = [Grade]()
    
    
    
    @IBOutlet var gradesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        gradesTableView.delegate = self
        gradesTableView.dataSource = self
        
        let teamsSegementedControl = XMSegmentedControl(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44), segmentTitle: ["LADDERS", "RESULTS", "MATCHES"], selectedItemHighlightStyle: XMSelectedItemHighlightStyle.bottomEdge)

        teamsSegementedControl.backgroundColor = COLOUR_DARK_MAROON
        teamsSegementedControl.highlightColor = COLOUR_YELLOW
        teamsSegementedControl.tint = UIColor.white
        teamsSegementedControl.highlightTint = COLOUR_YELLOW
        teamsSegementedControl.font = UIFont(name: "Dosis-SemiBold", size: 14.0)!
        
        self.view.addSubview(teamsSegementedControl)
        
        DataService.ds.REF_GRADES.observe(.value, with: { (snapshot) -> Void in
            self.grades = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    if let gradesDict = snap.value as? Dictionary<String,AnyObject> {
                        let key = snap.key
                        let grade = Grade(gradeKey: key, dictionary: gradesDict)
                        self.grades.append(grade)
                        self.grades.sort(by: {$0.gradeKey!  < $1.gradeKey! })
                        
                    }
                }
            }
            self.gradesTableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return grades.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let grade = grades[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "gradeCell", for: indexPath) as? GradeCell {
            cell.configureGradeCell(grade: grade)
            return cell
        } else {
            return GradeCell()
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
