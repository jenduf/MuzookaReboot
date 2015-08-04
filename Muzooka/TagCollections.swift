
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
    
    func getSectionsAvailable() -> [TagSection]
    {
        var sectionsAvailable = [TagSection]()
        
        if !self.featuredTags.isEmpty
        {
            sectionsAvailable.append(TagCollections.TagSection.Featured)
        }
        
        if !self.citiesTags.isEmpty
        {
           sectionsAvailable.append(.Cities)
        }
        
        if !self.suggestedTags.isEmpty
        {
            sectionsAvailable.append(TagSection.Suggested)
        }
        
        return sectionsAvailable
    }
    
    func getTagSectionAtIndex(index: Int) -> TagSection
    {
        let sectionsAvailable = self.getSectionsAvailable()
        
        let tagSection = sectionsAvailable[index] as TagSection
        
        return tagSection
    }
	
	func getRowCountForTagSection(section: Int) -> Int
	{
        let tagSection = self.getTagSectionAtIndex(section)
        
		switch tagSection
		{
			case .Featured:
				return self.featuredTags.count
			
			case .Cities:
				return self.citiesTags.count
				
			case .Suggested:
				return self.suggestedTags.count
		}
	}
	
	func getTagInfoForTagSectionAtRowIndex(section: TagSection, index: Int) -> TagInfo?
	{
		switch section
		{
			case .Featured:
                if self.featuredTags.count > index
                {
                    return self.featuredTags[index] as TagInfo
                }
            
			case .Cities:
                if self.citiesTags.count > index
                {
                    return self.citiesTags[index] as TagInfo
                }
            
			case .Suggested:
                if self.suggestedTags.count > index
                {
                    return self.suggestedTags[index] as TagInfo
                }
        }
        
        return nil
	}
}