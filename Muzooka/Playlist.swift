
//
//  Playlist.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/26/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public class Playlist
{
	public let playlistID: Int
	public let name: String
	public let songCount: Int
	public let subscribers: Int
	public let artwork: String
	public let ownerName: String?
	
	public init(dict: NSDictionary)
	{
		self.playlistID = dict["id"] as! Int
		self.name = dict["name"] as! String
		self.songCount = dict["songs_count"] as! Int
		self.subscribers = dict["subscribers"] as! Int
		self.artwork = dict["artwork"] as! String
		
		let ownerDict = dict["owner"] as! NSDictionary
		self.ownerName = ownerDict["name"] as? String
	}
}