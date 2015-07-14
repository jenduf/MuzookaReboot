
//
//  User.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/6/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public class User: NSObject, Shareable
{
	public var userID: Int = 0
	public var name: String
	public var userName: String
	public var bio: String
	public var city: String
	public var state: String
	public var country: String
	public var scoreDetails: ScoreDetails?
	public var email: String?
	public var followersCount: Int = 0
	public var followingCount: Int = 0
	public var likesCount: Int = 0
	public var avatarURL: String?
	public var playlistDictionary = OrderedDictionary<String, [Playlist]>()
	
	public var following: Bool = false
	
	static var currentUser: User!
	
	public init(dict: NSDictionary)
	{
		if let idValue = dict["id"] as? String
		{
			self.userID = idValue.toInt()!
		}
		else
		{
			self.userID = dict["id"] as! Int
		}
		
		self.name = Utils.nonNullObject(dict["name"]) as! String
		
		self.userName = Utils.nonNullObject(dict["username"]) as! String
		self.bio = Utils.nonNullObject(dict["bio"]) as! String
		self.city = Utils.nonNullObject(dict["city"]) as! String
		self.state = Utils.nonNullObject(dict["provstate"]) as! String
		self.country = Utils.nonNullObject(dict["country"]) as! String
		self.scoreDetails = ScoreDetails(dict: dict["scoredetails"] as! NSDictionary)
		
		if let emailString = dict["email"] as? String
		{
			self.email = emailString
		}
		
		if let details = dict["scoredetails"] as? NSDictionary
		{
			self.scoreDetails = ScoreDetails(dict: details)
		}
		
		self.followersCount = Utils.nonNullValue(dict["followers"]) as! Int
		self.followingCount = Utils.nonNullValue(dict["follows"]) as! Int
		self.likesCount = Utils.nonNullValue(dict["votes"]) as! Int
		
		if let avatarString = dict["avatar"] as? String
		{
			self.avatarURL = avatarString
		}
		
		if let userDict = dict["user"] as? NSDictionary
		{
			self.following = userDict["following"] as! Bool
		}
		
		super.init()
		
		if dict["playlists"] != nil
		{
			var playlistDict: NSDictionary = (dict["playlists"] as! NSDictionary)
			var personalPlaylists = self.getPlaylistFromDictionary(playlistDict) as! [(Playlist)]
			
			self.playlistDictionary.insert(personalPlaylists, forKey: Constants.KEY_PERSONAL_PLAYLISTS, atIndex: 0)
			
			var subscribedDict: NSDictionary = (dict["playlists_subscriptions"] as! NSDictionary)
			var subscribedPlaylists = self.getPlaylistFromDictionary(subscribedDict) as! [(Playlist)]
			
			self.playlistDictionary.insert(subscribedPlaylists, forKey: Constants.KEY_SUBSCRIBED_PLAYLISTS, atIndex: 1)
			//self.playlistDictionary[Constants.KEY_SUBSCRIBED_PLAYLISTS] = subscribedPlaylists
		}
	}
	
	func getPlaylistFromDictionary(playlistDict: NSDictionary) -> NSArray
	{
		var playlists = [Playlist]()
		
		var playlistArray: NSArray = (playlistDict["playlists"] as? NSArray)!
		
		for playDict in playlistArray
		{
			var playlist = Playlist(dict: playDict as! NSDictionary)
			playlists.append(playlist)
		}
		
		return playlists
	}
	
	// MARK: Shareable Helper Methods
	func getItemID() -> Int
	{
		return self.userID
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
		
		items.extend([ .ViewProfile, .Share ])
		
		return items
	}
	
	func getShareDetails() -> String
	{
		return self.userName
	}
	
	func getShareURL() -> NSURL
	{
		return NSURL(string: "\(Constants.WEB_URL)/u/\(self.userName)")!
	}
	
	func shareableType() -> MediaType
	{
		return .User
	}
	
}