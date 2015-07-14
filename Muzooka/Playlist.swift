
//
//  Playlist.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/26/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public class Playlist: NSObject, Shareable
{
	public let playlistID: Int
	public let name: String
	public let songCount: Int
	public let subscribers: Int
	public var artwork: String?
	public var ownerName: String?
	
	public init(dict: NSDictionary)
	{
		self.playlistID = dict["id"] as! Int
		self.name = dict["name"] as! String
		self.songCount = dict["songs_count"] as! Int
		self.subscribers = dict["subscribers"] as! Int
		
		if let artImage = dict["artwork"] as? String
		{
			self.artwork = artImage
		}
		
		if let ownerDict = dict["owner"] as? NSDictionary
		{
			self.ownerName = Utils.nonNullObject(ownerDict["name"]) as? String
		}
	}
	
	// MARK: Shareable Helper Methods
	func getItemID() -> Int
	{
		return self.playlistID
	}
	
	func getItemName() -> String
	{
		return self.name
	}
	
	func getActionItems() -> [MenuAction]
	{
		return [ .PlayLater, .SongInfo, .ArtistInfo, .AddToPlaylist, .Share ]
	}
	
	func getShareDetails() -> String
	{
		return "\(self.name) by \(self.ownerName)"
	}
	
	func getShareURL() -> NSURL
	{
		return NSURL(string: "\(Constants.WEB_URL)/p/\(self.playlistID)")!
	}
	
	func shareableType() -> MediaType
	{
		return .Playlist
	}
}