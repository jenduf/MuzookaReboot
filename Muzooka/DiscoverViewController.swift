//
//  DiscoverViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/13/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit
import AVFoundation

class DiscoverViewController: MuzookaViewController, DragDelegate, MusicPlayerDelegate, MuzookaAlertDelegate, AlbumScrollViewDataSource
{
	@IBOutlet var bannerView: BannerView!
	@IBOutlet var muzookaAlertView: MuzookaAlertView!
	@IBOutlet var discoverActionView: DiscoverActionView!
	
	@IBOutlet var albumScrollView: AlbumScrollView!
	
	var draggableImageView: DraggableImageView?
	
	var songs = [Song]()
	{
		didSet
		{
			self.albumScrollView.songs = songs
		}
			
	}
	
	var currentSong: Song?
	{
		didSet
		{
			self.discoverActionView.song = currentSong
			
			self.draggableImageView!.loadFromURL(NSURL(string:currentSong!.artwork!)!)
            
            let imageURL = ImageDimension.Medium.getImageDimensionAtURL(currentSong!.band.bannerURL!) as String
            
            self.bannerView.artURL =  imageURL
			
			self.muzookaAlertView.alertDelegate = self
			
			
			
			//MusicPlayer.sharedPlayer.playSong(currentSong!)
		}
	}

	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		MusicPlayer.sharedPlayer.delegate = self
		
		self.draggableImageView = DraggableImageView.new()
		self.view.insertSubview(self.draggableImageView!, aboveSubview: self.bannerView)
		self.draggableImageView?.frame = CGRect(x: 0, y: 0, width: self.view.width, height: self.view.width)
		
		// make this controller draggable image delegate
		self.draggableImageView?.dragDelegate = self
		
		//self.albumScrollView.albumScrollDataSource = self
	}
	
	override func loadData()
	{
		//var paramDict = NSDictionary(objectsAndKeys: Constants.TOTAL_QUEUE_COUNT, "count")
		//APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.Discovery, delegate: self, parameters: paramDict)
		
		let apiRequest = APIRequest(requestType: APIRequest.RequestType.Discovery, requestParameters: nil)
		
		APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self)
	}
	
	@IBAction func done(sender: AnyObject)
	{
		UIView.animateWithDuration(0.2, animations:
		{ () -> Void in
			self.muzookaAlertView.alpha = 1.0
		})
	}
	
	@IBAction func pass(sender: AnyObject?)
	{
		let apiRequest = APIRequest(requestType: APIRequest.RequestType.DiscoverPass, requestParameters: [APIRequestParameter(key: "\(self.currentSong!.songID)", value: "pass")])
		
		APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, postData: nil)
	}

	@IBAction func add(sender: AnyObject?)
	{
		let apiRequest = APIRequest(requestType: APIRequest.RequestType.DiscoverAdd, requestParameters: [APIRequestParameter(key: "\(self.currentSong!.songID)", value: "vote")])
		
		APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, postData: nil)
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: Drag View Delegate Methods
	func dragViewDragged(difference: CGFloat)
	{
		println("difference: \(difference)")
		
		let mainImageCenter = CGRectGetMidX(self.draggableImageView!.frame)
		
		self.discoverActionView.toggleButtonsForLocation(mainImageCenter)
	}
	
	func dragViewReset()
	{
		self.discoverActionView.reset()
	}
	
	func dragViewRequestedAdd()
	{
		self.discoverActionView.reset()
		
		self.add(nil)
	}
	
	func dragViewRequestedPass()
	{
		self.discoverActionView.reset()
		
		self.pass(nil)
	}
	
	// MARK: MusicPlayer Delegate Methods
	func musicPlayerDidUpdateTimeCode(musicPlayer: MusicPlayer, current: CMTime, total: CMTime)
	{
		let currentTotal = Int(CMTimeGetSeconds(current))
		
		let completeTotal = Float(CMTimeGetSeconds(total))
		
		let minutes = floorf(Float(currentTotal / 60))
		let seconds = floorf(Float(currentTotal % 60))
		
		let totalMinutes = floorf(Float(completeTotal / 60))
		let totalSeconds = floorf(Float(completeTotal % 60))
		
		// calculate indicator width
		let indicatorPercent = Float(currentTotal) / completeTotal
		
		self.discoverActionView.indicatorView.percent = CGFloat(indicatorPercent)
		
		//self.musicPlayerView.setPercent(CGFloat(indicatorPercent))
		
		
		//println("total: \(completeTotal) current total: \(currentTotal) minutes: \(minutes) seconds: \(seconds) indicator percent: \(indicatorPercent)")
	}
	
	func musicPlayerDidStartPlaying(musicPlayer: MusicPlayer, song: Song)
	{
		//self.toggleMusicPlayer()
		
		//self.musicPlayerView.togglePlayButton()
		
		//self.musicPlayerView.song = song
		
		self.currentSong = song
	}
	
	func musicPlayerDidToggle(musicPlayer: MusicPlayer)
	{
		//self.musicPlayerView.togglePlayButton()
	}
	
	func musicPlayerSongDidEnd(musicPlayer: MusicPlayer)
	{
		/*self.songs.removeAtIndex(0)
		
		if self.songs.count > 0
		{
			self.currentSong = self.songs[0]
		}*/
	}
	
	// MARK: MuzookaAlertDelegate Methods
	func alertViewDidDismissAtIndex(index: Int)
	{
		switch(index)
		{
			case 0:
				UIView.animateWithDuration(0.2, animations:
				{ () -> Void in
					self.muzookaAlertView.alpha = 0.0
				},
				completion:
				{ (Bool) -> Void in
					self.navController!.popViewController()
				})
				break
			
			case 1:
				MusicPlayer.sharedPlayer.addSongToPersonalQueue(self.currentSong!, playNow: false)
				self.navController!.popViewController()
				break
			
			case 2:
				
				break
			
			default:
			
				break
		}
		
	}
	
	// MARK: AlbumScrollView Delegate Methods
	func numberOfItemsInScrollView(scrollView: AlbumScrollView) -> Int
	{
		return self.songs.count
	}
	
	func viewForAlbumAtIndex(index: Int) -> AlbumArtView
	{
		let song = self.songs[index] as Song
		
		let albumArt = AlbumArtView(urlString: song.artwork!, frame: CGRect(x: 0, y: 0, width: Constants.ALBUM_ART_SIZE, height: Constants.ALBUM_ART_SIZE))
		
		return albumArt as AlbumArtView
	}

	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject?)
	{
		super.apiManagerDidReturnData(apiManager, data: data)
		
		switch apiManager.apiRequest!.requestType
		{
			case .Discovery:
				//if data != nil
				//{
					var dataDict:NSDictionary = data as! NSDictionary
					
					var songArray:NSArray = dataDict["songs"] as! NSArray
					
					for eachSong in songArray
					{
						var song = Song(dict:eachSong as! NSDictionary)
						self.songs.append(song)
					}
					
					//self.albumScrollView.layoutItems()
					
					MusicPlayer.sharedPlayer.addSongsToQueue(self.songs, mode:.Discovery, playIndex:0)
					//}
				break
			
			case .DiscoverAdd:
				MusicPlayer.sharedPlayer.addSongToPersonalQueue(self.currentSong!, playNow: false)
			
				break
			
			case .DiscoverPass:
			
				break
			
			default:
			
				break
		}
	}

}
