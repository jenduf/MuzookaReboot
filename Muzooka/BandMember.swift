
//
//  BandMember.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/13/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public struct BandMember
{
	public let role: String?
	public var isOwner: Bool = false
	public let memberID: Int
	public let name: String
	public let userName: String
	public let city: String?
    public var avatar: String?
    public var avatarURL: String?
    public var avatarDimensions = [ImageDimension]()

	
	public init(dict: NSDictionary)
	{
		self.role = dict["role"] as? String
		self.isOwner = dict["owner"] as! Bool
		
		var userDict: NSDictionary = (dict["user"] as? NSDictionary)!

		self.memberID = userDict["id"] as! Int
		self.name = userDict["name"] as! String
		self.userName = userDict["username"] as! String
		self.city = userDict["city"] as? String
        
        if let avatarString = dict["avatar"] as? String
        {
            self.avatar = avatarString
        }
        
        if let avatarDict = dict["avatars"] as? NSDictionary
        {
            if let url = avatarDict["template"] as? String
            {
                self.avatarURL = url
            }
            
            if let dimensions = avatarDict["dimensions"] as? NSArray
            {
                for dimension in dimensions
                {
                    let imageDimension = ImageDimension(rawValue: dimension as! String)
                    self.avatarDimensions.append(imageDimension!)
                }
            }
        }

	}
}