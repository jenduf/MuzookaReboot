//
//  SearchController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/1/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public class SearchController
{
	public var searchItems = [String]()
	public var recentlySearchedItems = [String]()
	
	public var selectedFilters = [String]()
	
	class var sharedController: SearchController
	{
		struct SharedInstance
		{
			static let instance = SearchController()
		}
		
		return SharedInstance.instance
	}
	
	public init()
	{
		self.recentlySearchedItems = loadRecentlySearched()
	}
	
	private func loadRecentlySearched() -> [String]
	{
		let searchArray = NSUserDefaults.standardUserDefaults().arrayForKey(Constants.RECENT_SEARCHES_KEY) as? [String]
		
		if searchArray != nil
		{
			return searchArray!
		}
		
		return [String]()
	}
	
	public func searchForItem(item: String)
	{
		let tempArray = self.recentlySearchedItems
		
		if !contains(self.recentlySearchedItems, item)
		{
			self.recentlySearchedItems.append(item)
			
			NSUserDefaults.standardUserDefaults().setObject(self.recentlySearchedItems, forKey: Constants.RECENT_SEARCHES_KEY)
		}
	}
	
	public func clearSearched()
	{
		self.recentlySearchedItems.removeAll()
	
		NSUserDefaults.standardUserDefaults().setObject(self.recentlySearchedItems, forKey: Constants.RECENT_SEARCHES_KEY)
	}
	
	public func addFilter(filter: String)
	{
		self.selectedFilters.append(filter)
	}
	
	public func removeFilter(filter: String)
	{
		self.selectedFilters.filter
		{
			$0.localizedCaseInsensitiveCompare(filter) == NSComparisonResult.OrderedSame
		}
	}
}