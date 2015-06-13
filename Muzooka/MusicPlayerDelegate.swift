
//
//  MusicPlayerDelegate.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/9/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import AVFoundation

protocol MusicPlayerDelegate
{
	func musicPlayerDidStartPlaying(musicPlayer: MusicPlayer, song: Song)
	func musicPlayerDidUpdateTimeCode(musicPlayer: MusicPlayer, current: CMTime, total: CMTime)
	func musicPlayerDidToggle(musicPlayer: MusicPlayer)
	func musicPlayerSongDidEnd(musicPlayer: MusicPlayer)
}