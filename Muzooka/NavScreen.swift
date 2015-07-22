//
//  NavScreen.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/15/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public enum NavScreen: Int
{
	case Login = 0, Charts, Playlists, Partners, Industry, Search, Settings, Artist, Song, Profile, EditProfile, SearchDetail, ExtendedPlayer, Discover, Filters
	
	public static let titles = ["", "Charts", "Playlists", "Partners", "Industry", "Search", "Settings", "", "", "", "Edit Profile", "Search", "", "", "Filters"]
	
	public var showNavBar: Bool
	{
		switch self
		{
			case .Profile, .ExtendedPlayer, .Discover:
				return false
			
			default:
				return true
		}
	}
	
	public var needsFullScreen: Bool
	{
		switch self
		{
			case .ExtendedPlayer:
				return true
			
			default:
				return false
		}
	}
	
	public var titleText: String
	{
		return NavScreen.titles[self.rawValue]
	}
	
	public var subHeadings: [String]
	{
		switch(self)
		{
			case .Charts:
				return ["Hot", "New", "Top"]
				
			case .Playlists:
				return ["Personal", "Subscribed"]
			
			case .SearchDetail:
				return ["All", "Songs", "Bands", "Users", "Playlists"]
			
			default:
				return []
		}
			
	}
}