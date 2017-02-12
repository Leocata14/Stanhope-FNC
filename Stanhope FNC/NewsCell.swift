//
//  NewsCell.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 19/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Kingfisher

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var newsImg: UIImageView!
    @IBOutlet weak var publishedDate: UILabel!
    
    var news: News!
    //var request: Request?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    override func draw(_ rect: CGRect) {
        //newsImg.clipsToBounds = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(news: News, img: UIImage?) {
        self.news = news
        
        self.title.text = news.title
        let convertedDate = newsDateStringToNSDate(date: news.pubDate!)
        let dateString = NewsDateToString(date: convertedDate)
        self.publishedDate.text = dateString
        
        
        if news.imgUrl != nil {
            
            if img != nil {
                
                self.newsImg.image = img
                
            } else {
 
                var request = Alamofire.request(news.imgUrl!).responseImage { response in
                    if let image  = response.result.value {
                        self.newsImg.image = image
                    }
                }

//                request = Alamofire.request(.GET, news.imgUrl!).validate(contentType: ["image/*"]).response(completionHandler: { request, response, data, err in
//                    
//                    if err == nil {
//                        let img = UIImage(data: data!)!
//                        self.newsImg.image = img
//                        //self.newsImg.kf_setImageWithURL(NSURL(string: news.imgUrl!), placeholderImage: nil)
//                        NewsViewController.imageCache.setObject(img, forKey: self.news.imgUrl!)
//                        
//                    }
//                    
//                })
            }
            
        } else {
            self.newsImg.isHidden = true
        }
    }
    
}
