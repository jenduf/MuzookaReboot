
//
//  Band.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public class Band
{
	public let bandID: Int
	public let name: String
	public let city: String?
	public let bio: String?
	public let webSite: String?
	public let followers: Int?
	public let avatar: String?
	public let banner: String?
	public var following: Bool = false
	public var isMember: Bool = false
	public let votes: Int?
	public var bandMembers = [BandMember]()
	public var songs = [Song]()
	
	public init(dict: NSDictionary)
	{
		self.bandID = dict["id"] as! Int
		self.name = dict["name"] as! String
		self.city = dict["city"] as? String
		self.bio = dict["bio"] as? String
		self.webSite = dict["website"] as? String
		self.followers = dict["followers"] as? Int
		self.avatar = dict["avatar"] as? String
		self.banner = dict["banner"] as? String
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
	
}
