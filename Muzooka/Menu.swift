
//
//  Menu.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public enum Menu: Int
{
	case Charts = 0, Playlists, Partners, Industry, Search, Settings
	
	public static let values = [Charts, Playlists, Partners, Industry, Search, Settings]
	
	private static let nameStrings = ["Charts", "Playlists", "Partners", "Industry", "Search", "Settings"]
	
	public var imageName: String
	{
		return "nav_\(Menu.nameStrings[self.rawValue].lowercaseString)_icon"
	}
	
	public var description: String
	{
		return Menu.nameStrings[self.rawValue]
	}
	
	public var subHeadings: [String]
	{
		switch(self)
		{
			case .Charts:
				return ["Hot", "New", "Top"]
			
			case .Playlists:
				return ["Personal", "Subscribed"]
			
			default:
				return []
		}
		
	}
}