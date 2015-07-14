//
//  MusicPlayer.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/15/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import MediaPlayer

class MusicPlayer: NSObject
{
	class var sharedPlayer: MusicPlayer
	{
		struct SharedInstance
		{
			static let instance = MusicPlayer()
		}
		
		return SharedInstance.instance
	}

	enum Mode: Int
	{
		case Hot = 0, New, Top, Playlist, Band, PlayLater, Discovery
	}
	
	var mode: Mode = .Hot
	{
		didSet
		{
			
		}
	}
	
	func getHeaderForCurrentMusicMode() -> String
	{
		switch(self.mode)
		{
			case .Hot:
				return "Playing from Hot Charts"
			
			case .New:
				return "Playing from New Charts"
			
			case .Top:
				return "Playing from Top Charts"
			
			case .Playlist:
				return "Playing from Playlist"
			
			case .Band:
				return "Playing from Band"
			
			case .PlayLater:
				return "Playing from custom list"
			
			case .Discovery:
				return "Playing from Discovery Queue"
			
			default:
				break
		}
	}
	
	private var statusContext = 0
	private var currentItemContext = 1
	private var rateContext = 2
	
	var songQueue = [Song]()
	var personalQueue = [Song]()

	
	var delegate: MusicPlayerDelegate?
	var audioPlayer: AVPlayer!
	var playerItem: AVPlayerItem!
	var nowPlaying: Song?
	
	var nowPlayingIndex: Int = 0
	
	var timeObserver: AnyObject?
	
	func addSongToPersonalQueue(song: Song, playNow: Bool)
	{
		self.personalQueue.append(song)
		
		if playNow == true
		{
			
		}
		
		
	}
	
	func addSongsToQueue(songs: [Song], mode: Mode, playIndex: Int)
	{
		self.clearQueue()
		
		self.mode = mode
		
		self.nowPlayingIndex = playIndex
		
		self.songQueue.extend(songs)
		
		self.playNext()
	}
	
	//var songArray = [AVPlayerItem]()
	
	func playSong(song: Song)
	{
		self.stop()
		
		self.nowPlaying = song
		
		self.delegate!.musicPlayerDidStartPlaying(self, song: song)
		
		var error: NSError?
		let songURL = NSURL(string: (self.mode == .Discovery ? song.discoveryURL : song.songURL))!
		println("song url: \(songURL.absoluteString)")
		
		//self.playerItem = AVPlayerItem(URL: songURL)
		//songArray.append(playerItem)
		
		let asset = AVURLAsset(URL: songURL, options: nil)
		let keys = ["playable", "tracks"]
		asset.loadValuesAsynchronouslyForKeys(keys, completionHandler:
		{ () -> Void in
			//println("tracks: \(asset.tracks)")
			//if asset.playable == true
			//{
				dispatch_async(dispatch_get_main_queue(),
				{
					/*self.playerItem = AVPlayerItem(asset: asset)
					self.playerItem.addObserver(self, forKeyPath: "status", options: .New | .Initial, context: &self.statusContext)
				
					NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerItemDidReachEnd:", name: AVPlayerItemDidPlayToEndTimeNotification, object: self.playerItem)*/
					
					self.prepareToPlayAssetWithKeys(asset, keys: keys)
				})
			//}
		})
	
		//self.avPlayer = AVPlayer(URL: songURL)//(playerItem: playerItem)//AVAudioPlayer(contentsOfURL: songURL, error: &error)
		
		
		
		/*if self.avPlayer == nil
		{
			if let e = error
			{
				println(e.localizedDescription)
			}
		}*/
		
		println("playing \(songURL)")
		
		//var interval = 0.1//0.5 * Float(dur) / Float(width)
		
			//self.avPlayer?.addPeriodicTimeObserverForInterval(CMTimeMake(Int64(interval), Int32(NSEC_PER_SEC)), queue: nil, usingBlock:
		//{ (CMTime) -> Void in
			
		//	})
		
		//self.avPlayer.delegate = self
		//self.avPlayer.prepareToPlay()
	}
	
	func toggleAVPlayer()
	{
		if self.audioPlayer != nil
		{
			if self.audioPlayer!.rate > 0
			{
				self.audioPlayer!.pause()
			}
			else
			{
				self.audioPlayer!.play()
			}
			
			self.delegate!.musicPlayerDidToggle(self)
		}
	}
	
	func playerItemDidReachEnd(player: AVPlayerItem)
	{
		self.nowPlayingIndex++
		
		self.delegate!.musicPlayerSongDidEnd(self)
	}
	
	func prepareToPlayAssetWithKeys(asset: AVURLAsset, keys: [String])
	{
		var error: NSError?
		
		for key in keys
		{
			let status = asset.statusOfValueForKey(key, error: &error) as AVKeyValueStatus
			
			if status == AVKeyValueStatus.Failed
			{
				return
			}
		}
		
		if !asset.playable
		{
			return
		}
		
		if self.playerItem != nil
		{
			self.playerItem.removeObserver(self, forKeyPath: "status")
			NSNotificationCenter.defaultCenter().removeObserver(self, name: AVPlayerItemDidPlayToEndTimeNotification, object: self.playerItem)
		}
		
		self.playerItem = AVPlayerItem(asset: asset)
		self.playerItem.addObserver(self, forKeyPath: "status", options: .Initial | .New, context: &self.statusContext)
		
		if self.audioPlayer == nil
		{
			self.audioPlayer = AVPlayer(playerItem: self.playerItem)
			
			self.audioPlayer.addObserver(self, forKeyPath: "currentItem", options: .Initial | .New, context: &self.currentItemContext)
			
			var interval = 1.0
			
			self.timeObserver = self.audioPlayer!.addPeriodicTimeObserverForInterval(CMTimeMake(Int64(interval), Int32(NSEC_PER_SEC)), queue: nil, usingBlock:
			{ (CMTime) -> Void in
					self.delegate!.musicPlayerDidUpdateTimeCode(self, current: self.audioPlayer.currentTime(), total: self.audioPlayer.currentItem.duration)
			})
		}
		
		if self.audioPlayer.currentItem != self.playerItem
		{
			self.audioPlayer.replaceCurrentItemWithPlayerItem(self.playerItem)
		}
	}
	
	override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>)
	{
		if context == &self.statusContext
		{
			//println("AVPlayerItem status: \(self.playerItem.status.rawValue)")
			let status = AVPlayerStatus(rawValue: (change as NSDictionary).objectForKey(NSKeyValueChangeNewKey) as! Int)
			if status == AVPlayerStatus.ReadyToPlay
			{
				self.play()
			}
		}
		else if context == &self.currentItemContext
		{
			//
		}
		else
		{
			super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
		}
		/*
				//if (self.playerItem.status == AVPlayerItemStatus.ReadyToPlay && self.avPlayer == nil)
			if self.avPlayer == nil
			{
				self.avPlayer = AVPlayer(playerItem: self.playerItem)
				self.avPlayer.addObserver(self, forKeyPath: "currentItem", options: .New | .Initial, context: &self.currentItemContext)
				self.avPlayer.addObserver(self, forKeyPath: "rate", options: .New | .Initial, context: &self.rateContext)
				//println("AVPlayer status: \(self.avPlayer.status.rawValue)")
				
				var interval = 1.0//0.5 * Float(dur) / Float(width)
				
				self.avPlayer!.addPeriodicTimeObserverForInterval(CMTimeMake(Int64(interval), Int32(NSEC_PER_SEC)), queue: nil, usingBlock:
				{ (CMTime) -> Void in
					self.delegate!.musicPlayerDidUpdateTimeCode(self, current: self.avPlayer.currentTime(), total: self.avPlayer.currentItem.duration)
				})
			}
		}
		else if context == &self.currentItemContext
		{
			let newItem = (change as NSDictionary).objectForKey(NSKeyValueChangeNewKey) as! AVPlayerItem
			if self.avPlayer.currentItem != newItem
			{
				self.avPlayer.replaceCurrentItemWithPlayerItem(newItem)
			}
			
			self.avPlayer.volume = 1.0
			self.avPlayer.play()
			//println("AVPlayer status: \(self.avPlayer.status.rawValue)")
		}
		else if context == &self.rateContext
		{
			//println("AVPlayer rate: \(self.avPlayer.rate)")
		}
		else
		{
			super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
		}*/
	}
	
	deinit
	{
		self.audioPlayer.removeObserver(self, forKeyPath: "currentItem")
		//self.avPlayer.removeObserver(self, forKeyPath: "rate")
		self.playerItem.removeObserver(self, forKeyPath: "status")
	}

	
	// MARK: Helpers
	func isPlaying() -> Bool
	{
		return (self.audioPlayer != nil && self.audioPlayer.rate != 0.0)
	}
	
	func isStopped() -> Bool
	{
		return (self.audioPlayer == nil || self.audioPlayer.rate == 0.0)
	}
	
	func play()
	{
		AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
		AVAudioSession.sharedInstance().setMode(AVAudioSessionModeDefault, error: nil)
		AVAudioSession.sharedInstance().setActive(true, error: nil)
		
		UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
		
		self.audioPlayer.play()
		
		self.updateNowPlayingInfo()
	}
	
	func pause()
	{
		self.audioPlayer.pause()
	}
	
	func stop()
	{
		AVAudioSession.sharedInstance().setActive(false, error: nil)
		
		UIApplication.sharedApplication().endReceivingRemoteControlEvents()
		
		if self.isPlaying()
		{
			self.audioPlayer.pause()
		}
		
		if self.timeObserver != nil
		{
			self.audioPlayer.removeTimeObserver(self.timeObserver)
		}
		
		self.audioPlayer = nil
		
		//AVAudioSession.sharedInstance().setActive(false, error: nil)
	}
	
	func playNext()
	{
		if self.nowPlayingIndex >= self.songQueue.count
		{
			return
		}
		
		let song = self.songQueue[self.nowPlayingIndex] as Song
		
		if self.isStopped()
		{
			self.playSong(song)
		}
	}
	
	func clearQueue()
	{
		self.songQueue.removeAll()
	}
	
	func getNowPlayingList() -> [Song]
	{
		var nowPlayingSlice: ArraySlice<Song> = self.songQueue[self.nowPlayingIndex...(self.songQueue.count - 1)]
		var nowPlayingArray: [Song] = Array(nowPlayingSlice)
		
		return nowPlayingArray
	}
	
	func updateNowPlayingInfo()
	{
		let artImage = MPMediaItemArtwork(image:UIImage(named: Constants.IMAGE_DEFAULT_ART))
		
		var nowPlayingDict: [String: AnyObject] =
		[
			MPMediaItemPropertyArtwork : artImage!,
			MPMediaItemPropertyTitle : self.nowPlaying!.name,
			MPMediaItemPropertyArtist : self.nowPlaying!.band.name,
			MPMediaItemPropertyPlaybackDuration : self.nowPlaying!.durationTime
		]
		
		//nowPlayingDict.updateValue(artImage!, forKey: MPMediaItemPropertyArtwork)
		//nowPlayingDict.updateValue(self.nowPlaying!.name, forKey: MPMediaItemPropertyTitle)
		//nowPlayingDict.updateValue(self.nowPlaying!.band.name, forKey: MPMediaItemPropertyArtist)
		//nowPlayingDict.updateValue(self.nowPlaying!.durationTime, forKey: MPMediaItemPropertyPlaybackDuration)
		
		
		//MPMediaItemPropertyArtwork : artImage,
		//		MPMediaItemPropertyTitle : song.name,
		//	MPMediaItemPropertyArtist : song.band.name,
		//	MPMediaItemPropertyPlaybackDuration : song.duration
		//]
		
		
			//if nowPlayingDict.count > 0
		//{
			MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = nowPlayingDict
		//}
	}
}

// MARK: AVAudioPlayerDelegate
extension MusicPlayer: AVAudioPlayerDelegate
{
	func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool)
	{
		println("finished playing \(flag)")
	
	}
	
	func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!)
	{
		println("\(error.localizedDescription)")
		
	}
}
