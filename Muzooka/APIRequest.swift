
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
	case Hot = 0, New, Top, Partner, Producers, Login, Register, FacebookRegister, GoogleRegister, VoteSong, User, UserDetails, Band, BandSongs, SongDetails, PersonalPlaylists, SubscribedPlaylists
	
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
			"playlists/subscriptions" // subscribed playlists
			
		]
		
		return urls[self.rawValue]
	}
	
	func getURLWithAppendedID(appendedID: String) -> String
	{
		switch self
		{
			case .BandSongs:
				return "\(APIRequest.Band.stringValue)/\(appendedID)/\(self.stringValue)"
			
			case .Band, .SongDetails, .UserDetails:
				return "\(self.stringValue)/\(appendedID)"
			
			case .PersonalPlaylists:
				return "users/\(appendedID)/\(self.stringValue)"
			
			case .SubscribedPlaylists:
				return "users/\(appendedID)/\(self.stringValue)"
			
			default:
				return self.stringValue
		}
		
	}
	
	var httpMethod: String
	{
		switch(self)
		{
			case .Login:
				return Constants.HTTP_POST
			
			case .Register:
				return Constants.HTTP_PUT
			
			case .VoteSong:
				return Constants.HTTP_PUT
			
			default:
				return Constants.HTTP_GET
		}
	}
	
	var requiresAuthentication: Bool
	{
		switch(self)
		{
			case .VoteSong:
				return true
			
			case .User:
				return true
			
			case .PersonalPlaylists, .SubscribedPlaylists:
				return true
			
			default:
				return false
		}
		
	}
}
