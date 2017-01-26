//
//  NewsTableVC.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 18/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Firebase

class NewsTableVC: UITableViewController {
    
    var news = [News]()
     static var imageCache = NSCache<AnyObject, AnyObject>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 225
        
        DataService.ds.REF_NEWS.observe(.value, with: { (snapshot) -> Void in
            
            self.news = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    if let newsDict = snap.value as? Dictionary<String,AnyObject> {
                        let key = snap.key
                        let news = News(newsKey: key, dicitionary: newsDict)
                        self.news.append(news)
                        
                        //self.news.sortInPlace({ $0.pubDate?.compare($1.pubDate!) == .OrderedDescending })
                        //_ = DataService.ds.REF_NEWS.child(key)
                        //print("SNAP:\(snap)")
                    }
                    //let reverseResults = self.news.reverse()
                    //self.news.sort({ $0.pubDate?.timeIntervalSince1970 < $1.pubDate?.timeIntervalSince1970 })
                    
                }
                
            }
            self.news = self.news.reversed()
            self.tableView.reloadData()
            print(self.news)
        })
        
        DataService.ds.REF_NEWS.keepSynced(true)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }



    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let new = news[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as? NewsCell {
            
            var img: UIImage?
            
            if let url = new.imgUrl{
                img = NewsTableVC.imageCache.object(forKey: url as AnyObject) as? UIImage
            }
            
            cell.configureCell(news: new, img: img)
            return cell
        } else {
            return NewsCell()
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
        if segue.identifier == SEGUE_NEWS_DETAIL {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! NewsDetailVC
                
                destinationController.newsUrl = news[indexPath.row].url
                destinationController.newsTitle = news[indexPath.row].title!
                
            }
        }
    }
    

}
