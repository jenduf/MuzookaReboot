
//
//  Song.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public class Song
{
	public let songID: Int
	public let name: String
	public let position: Int
	public let artwork: String
	public let band: Band
	public let listens: Int?
	public var downloadable: Bool = false
	public let duration: String?
	public let primaryTag: String?
	public var tags = [String]()
	public let votes: Int?
	public let price: Int?
	public var hotChartRank: Int = 0
	public var hotChartMin: Int = 0
	public var hotChartMax: Int = 0
	public var hotChartDays = [Int]()
	
	public init(dict: NSDictionary)
	{
		self.songID = dict["id"] as! Int
		self.name = dict["name"] as! String
		self.artwork = dict["artwork"] as! String
		self.position = dict["hotchartposition"] as! Int
		self.band = Band(dict: dict["band"] as! NSDictionary) as Band
		self.listens = dict["listens"] as? Int
		self.downloadable = dict["downloadable"] as! Bool
		self.duration = dict["duration"] as? String
		self.primaryTag = dict["primary_tag"] as? String
		
		if dict["tags"] != nil
		{
			var tagArray: NSArray = dict["tags"] as! NSArray
			
			for string in tagArray
			{
				self.tags.append(string as! String)
			}
		}
		
		self.votes = dict["votes"] as? Int
		self.price = dict["price"] as? Int
		
		self.hotChartRank = dict["hotchartposition"] as! Int
		
		if dict["hotchartpositions"] != nil
		{
			var hotDict = dict["hotchartpositions"] as! NSDictionary
			
			if hotDict["range"] != nil
			{
				var rangeDict = hotDict["range"] as! NSDictionary
				
				self.hotChartMin = rangeDict["min"] as! Int
				self.hotChartMax = rangeDict["max"] as! Int
			}
			
			if hotDict["past_days"] != nil
			{
				var daysArray = hotDict["past_days"] as! NSArray
				
				for day in daysArray
				{
					self.hotChartDays.append(day as! Int)
				}
			}
		}
	}
}