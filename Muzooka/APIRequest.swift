
//
//  APIRequest.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

enum APIRequest: Int
{
	case Hot = 0, New = 1, Top = 2, Partner = 3, Producers = 4, Login = 5, Register = 6, FacebookRegister = 7, GoogleRegister = 8, VoteSong = 9, User = 10, UserDetails = 11, Band = 12, BandSongs = 13, SongDetails = 14, PersonalPlaylists = 15, SubscribedPlaylists, CreatePlaylist, SubscribeToPlaylist, PlaylistDetails, Followers, Following, SearchAll, Discovery
	
	var stringValue: String
	{
		let urls =
		[
			
			"billboards/hot", // hot
			"billboards/new", // new
			"billboards/top", // top
			"partner_platforms",  // partners
			"producers", // producers
			"auth", // login
			"user/register", // register
			"users/facebook", // facebook register
			"users/google", // google register
			"user/votes", // vote for song
			"user", // user
			"users", // user details
			"bands", // band info
			"songs", // song list
			"songs", // song details
			"playlists", // personal playlists
			"playlists/subscriptions", // subscribed playlists
			"playlists", // create playlists
			"subscribe", //subscribe to playlist
			"playlists",
			"followers",
			"following/users",
			"search/all",
			"discovery"
		]
		
		return urls[self.rawValue]
	}
	
	func getURLWithAppendedID(appendedID: String) -> String
	{
		switch self
		{
			case .BandSongs:
				return "\(APIRequest.Band.stringValue)/\(appendedID)/\(self.stringValue)"
			
			case .Band, .SongDetails, .UserDetails, .PlaylistDetails:
				return "\(self.stringValue)/\(appendedID)"
			
			case .PersonalPlaylists:
				return "users/\(appendedID)/\(self.stringValue)"
			
			case .SubscribedPlaylists:
				return "users/\(appendedID)/\(self.stringValue)"
			
			case .SubscribeToPlaylist:
				return "\(APIRequest.CreatePlaylist.stringValue)/\(appendedID)/\(self.stringValue)"
			
			case .Followers:
				return "users/\(appendedID)/\(self.stringValue)"
			
			case .Following:
				return "users/\(appendedID)/\(self.stringValue)"
			
			default:
				if appendedID.isEmpty == true
				{
					return self.stringValue
				}
				else
				{
					return "\(self.stringValue)/\(appendedID)"
				}
		}
		
	}
	
	var httpMethod: String
	{
		switch(self)
		{
			case .Login, .CreatePlaylist:
				return Constants.HTTP_POST
			
			case .VoteSong, .SubscribeToPlaylist, .Register:
				return Constants.HTTP_PUT
			
			default:
				return Constants.HTTP_GET
		}
	}
	
	var requiresAuthentication: Bool
	{
		switch(self)
		{
			case .VoteSong, .Discovery:
				return true
			
			case .User:
				return true
			
			case .PersonalPlaylists, .SubscribedPlaylists, .CreatePlaylist:
				return true
			
			default:
				return false
		}
		
	}
	
	func buildReferrerWithAppendedIDAndExtraInfo(id: Int, extraInfo: String = "") -> APIReferrer?
	{
		var returnRefer: APIReferrer? = nil
		
		switch self
		{
			case .Hot:
				returnRefer = APIReferrer(type: .Charts, id: 0, extra: APIReferrer.ExtraInfo.Hot.rawValue, isQueue: false, isManual: false)
				break
			
			case .New:
				returnRefer = APIReferrer(type: .Charts, id: 0, extra: APIReferrer.ExtraInfo.New.rawValue, isQueue: false, isManual: false)
				break
				
			case .Top:
				returnRefer = APIReferrer(type: .Charts, id: 0, extra: APIReferrer.ExtraInfo.Top.rawValue, isQueue: false, isManual: false)
				break
			
			case .Partner:
				returnRefer = APIReferrer(type: .PartnerCharts, id: id, extra: extraInfo, isQueue: true, isManual: false)
				break
			
			case .PlaylistDetails:
				returnRefer = APIReferrer(type: .Playlist, id: id, extra: extraInfo, isQueue: true, isManual: true)
				break
			
			case .BandSongs:
				returnRefer = APIReferrer(type: .Band, id: id, extra: extraInfo, isQueue: false, isManual: false)
				break
			
			case .SearchAll:
				returnRefer = APIReferrer(type: .Search, id: id, extra: extraInfo, isQueue: false, isManual: false)
				break
			
			case .SongDetails:
				returnRefer = APIReferrer(type: .Song, id: id, extra: extraInfo, isQueue: false, isManual: false)
				break
			
			case .Discovery:
				returnRefer = APIReferrer(type: .Discovery, id: id, extra: extraInfo, isQueue: true, isManual: false)
				break
			
			default:
				break
		}
		
		return returnRefer
	}
}
