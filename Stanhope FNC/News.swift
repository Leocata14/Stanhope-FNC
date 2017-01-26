//
//  News.swift
//  Stanhope FNC
//
//  Created by Jason Leocata on 19/1/17.
//  Copyright © 2017 Jason Leocata. All rights reserved.
//

class News{
    
    private var _imgUrl: String?
    private var _title: String?
    private var _description: String?
    private var _content: String?
    private var _pubDate: String?
    private var _likes: Int!
    private var _newsKey: String!
    private var _url: String!
    
    var imgUrl: String? {
        return _imgUrl
    }
    
    var title: String? {
        return _title
    }
    
    var description: String?{
        return _description
    }
    
    var content: String?{
        return _content
    }
    
    var pubDate: String?{
        return _pubDate
    }
    
    var likes: Int{
        return _likes
    }
    
    var newsKey: String{
        return _newsKey
    }
    var url: String{
        return _url
    }
    
    
    init(imageUrl: String?,title: String,description: String) {
        self._imgUrl = imageUrl
        self._title = title
        self._description = description
        
    }
    
    init(newsKey: String, dicitionary: Dictionary<String,AnyObject>){
        self._newsKey = newsKey
        
        if let title = dicitionary["title"] as? String {
            self._title = title
        }
        
        if let imgUrl = dicitionary["imgUrl"] as? String {
            self._imgUrl = imgUrl
        }
        
        if let description = dicitionary["description"] as? String {
            self._description = description
        }
        
        if let content = dicitionary["content"] as? String {
            self._content = content
        }
        
        if let pubDate = dicitionary["pubDate"] as? String {
            self._pubDate = pubDate
        }
        
        if let likes = dicitionary["likes"] as? Int {
            self._likes = likes
        }
        if let url = dicitionary["url"] as? String {
            self._url = url
        }
    }
    
    
}
