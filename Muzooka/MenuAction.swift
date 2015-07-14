//
//  SongMenu.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/15/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public enum MenuAction: Int
{
	case PlayLater = 0, SongInfo, ArtistInfo, AddToPlaylist, Share, Follow, Unfollow, ViewProfile, Subscribe, Unsubscribe, PlayPlaylist
	
	public static let menuValues: [MenuAction] = [.PlayLater, .SongInfo, .ArtistInfo, .AddToPlaylist, .Share, .Follow, .Unfollow, .ViewProfile, .Subscribe, .Unsubscribe, .PlayPlaylist]
	
	private static let menuTitles: [String] = ["Play later", "Song Information", "Artist Information", "Add to Playlist", "Share", "Follow", "Unfollow", "View Profile", "Subscribe", "Unsubscribe", "Play"]
	
	public var title: String
	{
		return MenuAction.menuTitles[self.rawValue]
	}
}