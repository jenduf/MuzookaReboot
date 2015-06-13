
//
//  User.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/6/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public class User
{
	public var userID: Int = 0
	public let name: String
	public let userName: String
	public let city: String
	public let state: String
	public let country: String
	public let scoreDetails: ScoreDetails
	public var email: String?
	public var followersCount: Int = 0
	public var followingCount: Int = 0
	public var likesCount: Int = 0
	public var avatarURL: String?
	public var playlistDictionary = OrderedDictionary<String, [Playlist]>()
	
	//public var image: UIImage?
	
	static var currentUser: User!
	
	public init(dict: NSDictionary)
	{
		self.userID = dict["id"] as! Int
		
		self.name = Utils.nonNullObject(dict["name"]) as! String
		
		self.userName = dict["username"] as! String
		self.city = Utils.nonNullObject(dict["city"]) as! String
		self.state = Utils.nonNullObject(dict["provstate"]) as! String
		self.country = Utils.nonNullObject(dict["country"]) as! String
		self.scoreDetails = ScoreDetails(dict: dict["scoredetails"] as! NSDictionary)
		
		if dict["email"] != nil
		{
			self.email = dict["email"] as? String
		}
		
		self.followersCount = dict["followers"] as! Int
		self.followingCount = dict["follows"] as! Int
		self.likesCount = dict["votes"] as! Int
		
		if dict["avatar"] != nil
		{
			self.avatarURL = dict["avatar"] as? String
			
			//self.getImage()
		}
		
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
	
	
	func getImage()
	{
		if self.avatarURL != nil
		{
			let request = NSURLRequest(URL: NSURL(string: self.avatarURL!)!)
				NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
				{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
					let downloadedImage = UIImage(data: data)
					//self.image = downloadedImage
				}
		}
	}
	
}