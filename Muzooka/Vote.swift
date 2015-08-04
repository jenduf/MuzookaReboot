//
//  Vote.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/22/15.
//  Copyright (c) 2015 com.muzooka. All rights reserved.
//

import UIKit

public class Vote: NSObject
{
    var createdDate: NSDate?
    var user: User?
    var timeAgo: String?
    
    public init(dict: NSDictionary)
    {
        let dateStr = dict["created"] as! String
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'.000Z'"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
        
        self.createdDate = dateFormatter.dateFromString(dateStr)
        
        if let userDict = dict["user"] as? NSDictionary
        {
            self.user = User(dict: userDict)
        }
        
        self.timeAgo = dict["timeago"] as? String
    }
   
}
