
//
//  Song.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public class Song: NSObject, Shareable
{
	public var songID: Int = 0
	public var name: String = ""
	public var position: Int
	public var artwork: String?
	public var artworkURL: String?
	public var artworkDimensions = [ImageDimension]()
	public var band: Band
	public var listens: Int?
	public var downloadable: Bool = false
	public var duration: String?
	public var durationTime: Int = 0
	public var snippetStart: Int?
	public var primaryTag: String?
	public var tags = [String]()
	public var votes: Int?
	public var producerVotes: Int?
	public var price: Int?
    public var age: String?
	public var hotChartRank: Int = 0
    public var hotChartChange: Int = 0
	public var hotChartMin: Int = 0
	public var hotChartMax: Int = 0
	public var hotChartDays = [Int]()
	
	public var userVoted: Bool = false
	public var userListened: Bool = false
	public var userPurchased: Bool = false
	
	public var image: UIImage?
	
	public var songURL: String
	{
		get
		{
			return "\(Constants.SONG_URL)\(self.band.bandID)/songs/\(self.songID)_128.mp3"
		}
	}
	
	public var discoveryURL: String
	{
		get
		{
			return "\(Constants.SONG_URL)\(self.band.bandID)/songs/\(self.songID)_discovery.mp3"
		}
	}

	public init(dict: NSDictionary)
	{
		self.songID = dict["id"] as! Int
		
		if let songName = dict["name"] as? String
		{
			self.name = songName
		}
		
		if let artworkString = dict["artwork"] as? String
		{
			self.artwork = artworkString
		}
		
		if let artworkDict = dict["artworks"] as? NSDictionary
		{
			if let url = artworkDict["template"] as? String
			{
				self.artworkURL = url
			}
			
			if let dimensions = artworkDict["dimensions"] as? NSArray
			{
				for dimension in dimensions
				{
					let imageDimension = ImageDimension(rawValue: dimension as! String)
					self.artworkDimensions.append(imageDimension!)
				}
			}
		}
		
		self.position = dict["hotchartposition"] as! Int
		self.band = Band(dict: dict["band"] as! NSDictionary) as Band
		self.listens = dict["listens"] as? Int
		self.downloadable = dict["downloadable"] as! Bool
		
		self.duration = dict["duration"] as? String
		
		var durationArray = self.duration?.componentsSeparatedByString(":")
		var hours = 0
		var minutes = 0
		var seconds = 0
		
		if durationArray?.count == 3
		{
			hours = durationArray!.first!.toInt()!
			minutes = durationArray![1].toInt()!
			seconds = durationArray!.last!.toInt()!
		}
		else if durationArray?.count == 2
		{
			minutes = durationArray!.first!.toInt()!
			seconds = durationArray!.last!.toInt()!
		}
		else
		{
			let secondString = self.duration?.stringByTrimmingCharactersInSet(NSCharacterSet.letterCharacterSet())
			seconds = secondString!.toInt()!
		}
		
		self.durationTime = (hours * 3600 + minutes * 60 + seconds)
		
		//println("duration: \( (hours * 3600 + minutes * 60 + seconds))")
		
		self.snippetStart = dict["snippet_start"] as? Int
		self.primaryTag = dict["primary_tag"] as? String
		
		if let tagArray = dict["tags"] as? NSArray
		{
			for string in tagArray
			{
				self.tags.append(string as! String)
			}
		}
		
		self.votes = dict["votes"] as? Int
		self.producerVotes = dict["producer_votes"] as? Int
		self.price = dict["price"] as? Int
        
        self.age = dict["age"] as? String
		
		self.hotChartRank = dict["hotchartposition"] as! Int
		
		if let hotDict = dict["hotchartpositions"] as? NSDictionary
		{
			if let rangeDict = hotDict["range"] as? NSDictionary
			{
				self.hotChartMin = rangeDict["min"] as! Int
				self.hotChartMax = rangeDict["max"] as! Int
			}
			
			if let daysArray = hotDict["past_days"] as? NSArray
			{
				for day in daysArray
				{
					self.hotChartDays.append(day as! Int)
				}
                
                let day1 = daysArray[0] as! Int
                
                self.hotChartChange = -(self.hotChartRank - day1)
			}
			
		}
		
		if let userDict = dict["user"] as? NSDictionary
		{
			self.userVoted = userDict["voted"] as! Bool
			self.userListened = userDict["listened"] as! Bool
			self.userPurchased = userDict["purchased"] as! Bool
		}
	}
	
	// MARK: Shareable Helper Methods
	func getItemID() -> Int
	{
		return self.songID
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
		return "\(self.name) by \(self.band.name)"
	}
	
	func getShareURL() -> NSURL
	{
		return NSURL(string: "\(Constants.WEB_URL)\(self.band.subdomain!)/\(self.songID)")!
	}
	
	func shareableType() -> MediaType
	{
		return .Song
	}
}