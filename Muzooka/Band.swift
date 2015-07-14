
//
//  Band.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public class Band: NSObject, Shareable
{
	public let bandID: Int
	public let name: String
	public let subdomain: String?
	public let city: String?
	public let bio: String?
	public let webSite: String?
	public let followers: Int?
	public var avatar: String?
	public var avatarURL: String?
	public var avatarDimensions = [ImageDimension]()
	public var banner: String?
	public var bannerURL: String?
	public var bannerDimensions = [ImageDimension]()
	public var following: Bool = false
	public var isMember: Bool = false
	public let votes: Int?
	public var bandMembers = [BandMember]()
	public var songs = [Song]()
	
	public func getImageURLForDimension(dimension: ImageDimension, url: String) -> String
	{
		let imageString = url.stringByReplacingOccurrencesOfString("{%s}", withString: dimension.rawValue, options: NSStringCompareOptions.allZeros, range: nil)
		
		return imageString
	}
	
	public init(dict: NSDictionary)
	{
		self.bandID = dict["id"] as! Int
		self.name = dict["name"] as! String
		self.subdomain = Utils.nonNullObject(dict["subdomain"]) as? String
		self.city = Utils.nonNullObject(dict["city"]) as? String
		self.bio = Utils.nonNullObject(dict["bio"]) as? String
		self.webSite = Utils.nonNullObject(dict["website"]) as? String
		self.followers = dict["followers"] as? Int
		
		if let avatarImage = dict["avatar"] as? String
		{
			self.avatar = avatarImage
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
		
		if let bannerImage = dict["banner"] as? String
		{
			self.banner = bannerImage
		}
		
		if let bannerDict = dict["banners"] as? NSDictionary
		{
			if let url = bannerDict["template"] as? String
			{
				self.bannerURL = url
			}
			
			if let dimensions = bannerDict["dimensions"] as? NSArray
			{
				for dimension in dimensions
				{
					let imageDimension = ImageDimension(rawValue: dimension as! String)
					self.bannerDimensions.append(imageDimension!)
				}
			}
		}
		
		self.votes = dict["votes"] as? Int
		
		if dict["members"] != nil
		{
			var memberArray: NSArray = dict["members"] as! NSArray
		
			for member in memberArray
			{
				var bandMember = BandMember(dict: member as! NSDictionary)
				self.bandMembers.append(bandMember)
			}
		}
		
		if dict["songs"] != nil
		{
			var songDict: NSDictionary = (dict["songs"] as? NSDictionary)!
			var songArray: NSArray = (songDict["songs"] as? NSArray)!
			
			for song in songArray
			{
				var song = Song(dict: song as! NSDictionary)
				self.songs.append(song)
			}
		}
		
		if dict["user"] != nil
		{
			var user = dict["user"] as! NSDictionary
			self.following = user["following"]!.boolValue
		}
	}
	
	// MARK: Shareable Helper Methods
	func getItemID() -> Int
	{
		return self.bandID
	}
	
	func getItemName() -> String
	{
		return self.name
	}
	
	func getActionItems() -> [MenuAction]
	{
		var items = [MenuAction]()
		
		if self.following == true
		{
			items.append(.Unfollow)
		}
		else
		{
			items.append(.Follow)
		}
		
		items.extend([ .PlayLater, .ViewProfile, .Share ])
		
		return items
	}
	
	func getShareDetails() -> String
	{
		return "\(self.name)"
	}
	
	func getShareURL() -> NSURL
	{
		return NSURL(string: "\(Constants.WEB_URL)\(self.subdomain)")!
	}
	
	func shareableType() -> MediaType
	{
		return .Band
	}
	
}
