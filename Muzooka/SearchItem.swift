
//
//  SearchItem.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/1/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public class SearchItem
{
	var searchItemType: SearchItemType!
	
	public var band: Band?
	public var user: User?
	public var song: Song?
	public var playlist: Playlist?
	
	public init(dict: NSDictionary)
	{
		self.searchItemType = SearchItemType(rawValue: dict["type"] as! String)
		
		switch self.searchItemType!
		{
			case .Band:
				self.band = Band(dict: dict)
				break
			
			case .Song:
				self.song = Song(dict: dict)
				break
			
			case .User:
				self.user = User(dict: dict)
				break
			
			case .Playlist:
				self.playlist = Playlist(dict: dict)
				break
			
			default:
				break
		}
	}
	
	public func getItemName() -> String?
	{
		switch self.searchItemType!
		{
			case .Band:
				return self.band!.name
			
			case .Song:
				return self.song!.name
			
			case .User:
				return self.user!.name
			
			case .Playlist:
				return self.playlist!.name
			
			default:
				return nil
		}
	}
	
	public func getItemDescription() -> String
	{
		switch self.searchItemType!
		{
			case .Band:
				return self.band!.name
				
			case .Song:
				return self.song!.band.name
				
			case .User:
				return "\(self.user!.city), \(self.user!.state), \(self.user!.country)"
				
			case .Playlist:
				return "by \(self.playlist!.ownerName)"
			
			default:
				return ""
		}
	}
	
	public func getArtwork() -> String?
	{
		switch self.searchItemType!
		{
			case .Playlist:
				return self.playlist!.artwork
			
			case .Song:
				return self.song!.artwork
			
			case .User:
				return self.user!.avatarURL
			
			case .Band:
				return self.band!.banner
			
			default:
				return ""
		}
	}
}