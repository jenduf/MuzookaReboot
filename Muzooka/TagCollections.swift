
//
//  TagCollections.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/2/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation


public struct TagCollections
{
	public enum TagSection: Int
	{
		case Featured = 0, Cities, Suggested
		
		private static let sectionStrings = ["Featured", "Cities", "Suggested"]
		
		public var stringValue: String
		{
			return TagSection.sectionStrings[self.rawValue]
		}
	}
	
	var featuredTags = [TagInfo]()
	var citiesTags = [TagInfo]()
	var suggestedTags = [TagInfo]()
	
	init(dict: NSDictionary)
	{
		if let fArray = dict["featured"] as? NSArray
		{
			for itemDict in fArray
			{
				let featuredItem = TagInfo(dict: itemDict as! NSDictionary)
				self.featuredTags.append(featuredItem)
			}
		}
		
		if let cArray = dict["cities"] as? NSArray
		{
			for itemDict in cArray
			{
				let cityItem = TagInfo(dict: itemDict as! NSDictionary)
				self.citiesTags.append(cityItem)
			}
		}
		
		if let sArray = dict["suggested"] as? NSArray
		{
			for itemDict in sArray
			{
				let suggestedItem = TagInfo(dict: itemDict as! NSDictionary)
				self.suggestedTags.append(suggestedItem)
			}
		}
	}
	
	func getSectionCount() -> Int
	{
		var sectionCount = 0
		
		if !self.featuredTags.isEmpty
		{
			sectionCount += 1
		}
		
		if !self.citiesTags.isEmpty
		{
			sectionCount += 1
		}
		
		if !self.suggestedTags.isEmpty
		{
			sectionCount += 1
		}
		
		return sectionCount as Int
	}
	
	func getRowCountForTagSection(section: TagSection) -> Int
	{
		switch section
		{
			case .Featured:
				return self.featuredTags.count
			
			case .Cities:
				return self.citiesTags.count
				
			case .Suggested:
				return self.suggestedTags.count
		}
	}
	
	func getTagInfoForTagSectionAtRowIndex(section: TagSection, index: Int) -> TagInfo
	{
		switch section
		{
			case .Featured:
				return self.featuredTags[index] as TagInfo
				
			case .Cities:
				return self.citiesTags[index] as TagInfo
				
			case .Suggested:
				return self.suggestedTags[index] as TagInfo
		}
	}
}