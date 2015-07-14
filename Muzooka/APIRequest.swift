
//
//  APIRequest.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public struct APIRequest
{
	public let requestType: RequestType
	
	public let requestParameters: [APIRequestParameter]?
	
	
	public enum RequestType: Int
	{
		case Hot = 0, New = 1, Top = 2, Partner = 3, Producers = 4, Login = 5, Register = 6, FacebookRegister, GoogleRegister, VoteSong, UnVoteSong, User, UserDetails, Band, BandSongs, SongDetails, PersonalPlaylists, SubscribedPlaylists, CreatePlaylist, SubscribeToPlaylist, PlaylistDetails, AddSongToPlaylist, Followers, Following, SearchAll, Discovery, DiscoverPass, DiscoverAdd, FollowUser, UnfollowUser, FollowBand, UnfollowBand, Subscribe, Unsubscribe, Tags, SearchTags
		
		public static let values = [Hot, New, Top, Partner, Producers, Login, Register, FacebookRegister, GoogleRegister, VoteSong, UnVoteSong, User, UserDetails, Band, BandSongs, SongDetails, PersonalPlaylists, SubscribedPlaylists, CreatePlaylist, SubscribeToPlaylist, PlaylistDetails, AddSongToPlaylist, Followers, Following, SearchAll, Discovery, DiscoverPass, DiscoverAdd, FollowUser, UnfollowUser, FollowBand, UnfollowBand, Subscribe, Unsubscribe, Tags, SearchTags]
	
	
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
				"user/votes", // remove vote for song
				"user", // user
				"users", // user details
				"bands", // band info
				"songs", // song list
				"songs", // song details
				"playlists", // personal playlists
				"playlists/subscriptions", // subscribed playlists
				"playlists", // create playlists
				"subscribe", //subscribe to playlist
				"playlists", // playlist details
				"playlists", // add song to playlist
				"followers",
				"following/users",
				"search/all",
				"discovery",
				"discovery",
				"discovery",
				"user/following/users",
				"user/following/users",
				"user/following/bands",
				"user/following/bands",
				"playlists",
				"playlists",
				"search/tags",
				"search/tags"
				
			]
			
			return urls[self.rawValue]
		}
	}
	
	
	func getURLWithParameters() -> String
	{
		var urlString = self.requestType.stringValue
		
		if self.requestParameters != nil
		{
			for item in self.requestParameters!
			{
				urlString.extend("\(item.key)/\(item.value)")
			}
		}
		
		return urlString
	}
	
	
	func getURLWithAppendedID(appendedID: String) -> String
	{
		/*
		switch self.requestType
		{
			case .BandSongs:
				return "\(APIRequestType.Band.stringValue)/\(appendedID)/\(self.stringValue)"
				
			case .Band, .SongDetails, .UserDetails, .PlaylistDetails:
				return "\(self.stringValue)/\(appendedID)"
				
			case .PersonalPlaylists:
				return "users/\(appendedID)/\(self.stringValue)"
				
			case .SubscribedPlaylists:
				return "users/\(appendedID)/\(self.stringValue)"
				
			case .SubscribeToPlaylist:
				return "\(APIRequestType.CreatePlaylist.stringValue)/\(appendedID)/\(self.stringValue)"
				
			case .AddSongToPlaylist:
				return "\(APIRequestType.CreatePlaylist.stringValue)/\(appendedID)/\(self.stringValue)"
				
			case .Followers:
				return "users/\(appendedID)/\(self.stringValue)"
				
			case .Following:
				return "users/\(appendedID)/\(self.stringValue)"
				
			case .DiscoverPass, .DiscoverAdd:
				return "\(APIRequestType.Discovery.stringValue)/\(appendedID)/\(self.stringValue)"
				
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
	*/
		return ""
	}
	
	var httpMethod: String
	{
		switch(self.requestType)
		{
			case .Login, .CreatePlaylist:
				return Constants.HTTP_POST
				
			case .VoteSong, .SubscribeToPlaylist, .Register, .DiscoverAdd, .DiscoverPass, .AddSongToPlaylist, .FollowUser, .FollowBand, .Subscribe:
				return Constants.HTTP_PUT
				
			case .UnVoteSong, .UnfollowBand, .UnfollowUser, .Unsubscribe:
				return Constants.HTTP_DELETE
				
			default:
				return Constants.HTTP_GET
		}
	}
	
	var requiresAuthentication: Bool
	{
		switch(self.requestType)
		{
			case .FollowBand, .FollowUser, .UnfollowBand, .UnfollowUser, .Subscribe, .Unsubscribe:
				return true
			
			case .VoteSong, .Discovery, .UnVoteSong:
				return true
				
			case .User, .Band:
				return true
				
			case .PersonalPlaylists, .SubscribedPlaylists, .CreatePlaylist, .AddSongToPlaylist:
				return true
				
			default:
				return false
		}
			
	}
	
	func buildReferrerWithAppendedIDAndExtraInfo(id: Int, extraInfo: String = "") -> APIReferrer?
	{
		var returnRefer: APIReferrer? = nil
		
		switch self.requestType
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
