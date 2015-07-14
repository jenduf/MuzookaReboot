//
//  SearchItemType.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/1/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

enum MediaType: String
{
	case Band = "band", Song = "song", User = "user", Playlist = "playlist", All = "all"
	
	static func getItemFromInt(index: Int) -> MediaType
	{
		switch index
		{
			case 0:
				return .All
			
			case 1:
				return .Song
			
			case 2:
				return .Band
			
			case 3:
				return .User
			
			case 4:
				return .Playlist
			
			default:
				return .All
		}
	}
}
