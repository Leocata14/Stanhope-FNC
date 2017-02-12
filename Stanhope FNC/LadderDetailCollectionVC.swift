//
//  LadderDetailCollectionVC.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 27/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

private let reuseIdentifier = "customCell"

class LadderDetailCollectionVC: UICollectionViewController {
    
    var grade: Grade!
    
    var footballurl = ""
    var netballUrl = ""
    var ladderRow = Array<String>()
    var ladderArray = Array<Array<String>>()
    
    var football = true

    override func viewDidLoad() {
        super.viewDidLoad()
        ladderArray.append(self.ladderRow)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return ladderArray.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return ladderRow.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LadderCollectionViewCell
            
            cell.label.text = ladderArray[indexPath.section][indexPath.row]
            cell.backgroundColor = COLOUR_DARK_MAROON
            cell.label.textColor = COLOUR_YELLOW
            cell.label.text?.uppercased()
            cell.label.font = UIFont(name: "Dosis-SemiBold", size: 14.0)!
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LadderCollectionViewCell
            
            cell.label.text = ladderArray[indexPath.section][indexPath.row]
            cell.backgroundColor = UIColor.white
            cell.label.textColor = COLOUR_CHARCOAL
            
            if indexPath.row == 1 {
                cell.label.textAlignment = .left
            }
            
            return cell
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.footballurl = grade.ladderUrl!
        self.netballUrl = grade.ladderUrl!
        scrapeWebPage()
    }
    
    func scrapeWebPage() -> Void {
        var url = ""
        if football {
            url = footballurl
        } else {
            url = netballUrl
        }
        
        Alamofire.request(url).responseString { response in
            print("\(response.result.isSuccess)")
            if let html = response.result.value {
                self.parseHTML(html: html)
            }
        }
    }
    
    func parseHTML(html: String) -> Void {
        if football {
            if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
                
                for table in doc.css("table[class^='tableClass']") {
                    for th in table.css("th[class^='ladder-']") {
                        ladderRow.append(th.text!)
                    }
                    ladderArray.append(ladderRow)
                    
                    for tr in table.css("tr") {
                        var rowArray = [String]()
                        for td in tr.css("td[class^='ladder-']") {
                            rowArray.append(td.text!)
                        }
                        if rowArray.isEmpty ==  false {
                            ladderArray.append(rowArray)
                        }
                    }
                    ladderArray.remove(at: 0)
                    print(ladderArray)
                }
            }
            let layout = self.collectionView?.collectionViewLayout as? LadderCollectionViewLayout
            layout?.dataSourceDidUpdate = true
            self.collectionView!.reloadData()
        } else {
            if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
                for heading in doc.css("td[class^='h2']") {
                    if (heading.content?.contains("A Grade"))! {
                        if let tr = heading.parent {
                            let fullTable = tr.parent
                            for table in (fullTable?.css("table[id^='tblLadderInner']"))! {
                                for th in table.css("th") {
                                    ladderRow.append(th.text!)
                                }
                                ladderArray.append(ladderRow)
                                for tr in table.css("tr") {
                                    var rowArray = [String]()
                                    
                                    for td in tr.css("td") {
                                        if td.className != "c" {
                                            rowArray.append(td.text!)
                                        }
                                        
                                        
                                    }
                                    
                                    if rowArray.isEmpty == false {
                                        ladderArray.append(rowArray)
                                    }
                                    
                                }
                                
                                ladderArray.remove(at: 0)
                                print(ladderArray)
                            }
                        }
                    }
                }
            }
            let layout = self.collectionView?.collectionViewLayout as? LadderCollectionViewLayout
            layout?.dataSourceDidUpdate = true
            self.collectionView!.reloadData()
        }
    }
    

    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
