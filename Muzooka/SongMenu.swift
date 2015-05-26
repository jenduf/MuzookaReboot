//
//  SongMenu.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/15/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public enum SongMenu: Int
{
	case PlayLater = 0, SongInfo, ArtistInfo, AddToPlaylist, Share
	
	public static let songMenuValues: [SongMenu] = [.PlayLater, .SongInfo, .ArtistInfo, .AddToPlaylist, .Share]
	
	private static let songMenuTitles: [String] = ["Play later", "Song Information", "Artist Information", "Add to Playlist", "Share"]
	
	public var title: String
	{
		return SongMenu.songMenuTitles[self.rawValue]
	}
}