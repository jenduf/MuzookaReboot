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
		case Charts = 0, Playlist, Band, PlayLater
	}
	
	private var statusContext = 0
	private var currentItemContext = 1
	private var rateContext = 2

	
	var delegate: MusicPlayerDelegate?
	var avPlayer: AVPlayer!
	var playerItem: AVPlayerItem!
	var nowPlaying: Song?
	
	//var songArray = [AVPlayerItem]()
	
	func playSong(song: Song)
	{
		//AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
		//AVAudioSession.sharedInstance().setMode(AVAudioSessionModeDefault, error: nil)
		//AVAudioSession.sharedInstance().setActive(true, error: nil)
		
		self.nowPlaying = song
		
		self.delegate!.musicPlayerDidStartPlaying(self, song: song)
		
		var error: NSError?
		let songURL = NSURL(string: song.songURL)!
		
		//self.playerItem = AVPlayerItem(URL: songURL)
		//songArray.append(playerItem)
		
		let asset = AVURLAsset(URL: songURL, options: nil)
		asset.loadValuesAsynchronouslyForKeys(["playable"], completionHandler:
		{ () -> Void in
			//println("tracks: \(asset.tracks)")
			if asset.playable == true
			{
				dispatch_async(dispatch_get_main_queue(),
				{
					self.playerItem = AVPlayerItem(asset: asset)
					self.playerItem.addObserver(self, forKeyPath: "status", options: .New | .Initial, context: &self.statusContext)
				
					NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerItemDidReachEnd:", name: AVPlayerItemDidPlayToEndTimeNotification, object: self.playerItem)
				})
			}
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
		if self.avPlayer != nil
		{
			if self.avPlayer!.rate > 0
			{
				self.avPlayer!.pause()
			}
			else
			{
				self.avPlayer!.play()
			}
			
			self.delegate!.musicPlayerDidToggle(self)
		}
	}
	
	func playerItemDidReachEnd(player: AVPlayerItem)
	{
		self.delegate!.musicPlayerSongDidEnd(self)
	}
	
	override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>)
	{
		if context == &self.statusContext
		{
			println("AVPlayerItem status: \(self.playerItem.status.rawValue)")
			
				//if (self.playerItem.status == AVPlayerItemStatus.ReadyToPlay && self.avPlayer == nil)
			if self.avPlayer == nil
			{
				self.avPlayer = AVPlayer(playerItem: self.playerItem)
				self.avPlayer.addObserver(self, forKeyPath: "currentItem", options: .New | .Initial, context: &self.currentItemContext)
				self.avPlayer.addObserver(self, forKeyPath: "rate", options: .New | .Initial, context: &self.rateContext)
				println("AVPlayer status: \(self.avPlayer.status.rawValue)")
				
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
			println("AVPlayer status: \(self.avPlayer.status.rawValue)")
		}
		else if context == &self.rateContext
		{
			println("AVPlayer rate: \(self.avPlayer.rate)")
		}
		else
		{
			super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
		}
	}
	
	deinit
	{
		self.avPlayer.removeObserver(self, forKeyPath: "currentItem")
		self.playerItem.removeObserver(self, forKeyPath: "status")
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
