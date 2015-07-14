
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
	var searchItemType: MediaType!
	
	public var band: Band?
	public var user: User?
	public var song: Song?
	public var playlist: Playlist?
	
	public init(dict: NSDictionary)
	{
		self.searchItemType = MediaType(rawValue: dict["type"] as! String)
		
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
	
	func getShareableItem() -> Shareable?
	{
		switch self.searchItemType!
		{
		case .Band:
			return self.band! as Shareable
			
		case .Song:
			return self.song! as Shareable
			
		case .User:
			return self.user! as Shareable
			
		case .Playlist:
			return self.playlist! as Shareable
			
		default:
			break
		}
		
		return nil
	}
	
	public func getItemID() -> Int?
	{
		switch self.searchItemType!
		{
			case .Band:
				return self.band!.bandID
				
			case .Song:
				return self.song!.songID
				
			case .User:
				return self.user!.userID
				
			case .Playlist:
				return self.playlist!.playlistID
				
			default:
				return 0
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
				var cityString = (!self.user!.city.isEmpty ? self.user!.city : "")
				if !cityString.isEmpty && !self.user!.state.isEmpty
				{
					cityString.extend(", \(self.user!.state)")
				}
				else if !self.user!.state.isEmpty
				{
					cityString.extend(self.user!.state)
				}
				
				if !cityString.isEmpty && !self.user!.country.isEmpty
				{
					cityString.extend(", \(self.user!.country)")
				}
				else if !self.user!.country.isEmpty
				{
					cityString.extend(self.user!.country)
				}
				
				return cityString

				
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