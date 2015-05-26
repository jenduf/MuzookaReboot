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
	case Login = 0, Charts, Playlists, Partners, Industry, Search, Settings, Artist, Song, Profile, EditProfile
	
	public var titleText: String
	{
		switch self
		{
			case .Charts:
				return "Charts"
			
			case .Playlists:
				return "Playlists"
			
			case .EditProfile:
				return "Edit Profile"
			
			default:
				return ""
		}
		
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