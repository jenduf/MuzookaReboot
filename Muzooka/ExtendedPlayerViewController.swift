
//
//  ExtendedPlayerViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/9/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit
import AVFoundation

class ExtendedPlayerViewController: MuzookaViewController, UITableViewDataSource, UITableViewDelegate, MusicPlayerDelegate
{
	@IBOutlet var playerTableView: UITableView!
	@IBOutlet var playerScrollView: UIScrollView!
	@IBOutlet var musicPlayerView: MusicPlayerView!
	@IBOutlet var bannerView: BannerView!

	var playlistDictionary = [String: [Song]]()
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		self.playerScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.playerTableView.frame.maxY)
		
		MusicPlayer.sharedPlayer.delegate = self
		
		self.musicPlayerView.song = MusicPlayer.sharedPlayer.nowPlaying
		
		let band = MusicPlayer.sharedPlayer.nowPlaying!.band
		
		self.bannerView.artURL = band.banner!//band.getImageURLForDimension(.Medium, url: band.avatarURL!)
	}
	
	override func loadData()
	{
		super.loadData()

		let nowPlaying = MusicPlayer.sharedPlayer.getNowPlayingList()
		if nowPlaying.count > 0
		{
			self.playlistDictionary[Constants.KEY_HOT_CHARTS] = nowPlaying
		}
		
		let personalQueue = MusicPlayer.sharedPlayer.personalQueue
		if personalQueue.count > 0
		{
			self.playlistDictionary[Constants.KEY_QUEUE] = personalQueue
		}
		
		self.playerTableView.reloadData()

		//APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.Hot, delegate: self)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func close(sender: AnyObject)
	{
		self.navController!.hideModalViewController()
	}
	
	@IBAction func discover(sender: AnyObject)
	{
		self.navController!.navigateToControllerWithIdentifier(Constants.DISCOVER_VIEW_CONTROLLER)
	}
    

	// MARK: - Table View
	func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
		return self.playlistDictionary.count
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		let arr = Array(self.playlistDictionary.keys)
		let key = arr[section]
		
		let songs = self.playlistDictionary[key]
		
		return songs!.count
		
		//return min(songs.count, Constants.TOTAL_QUEUE_COUNT)
		
		//return min(MusicPlayer.sharedPlayer.getNowPlayingList().count, Constants.TOTAL_QUEUE_COUNT)
	}
	
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
	{
		var headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: Constants.PLAYLIST_HEADER_HEIGHT))
		headerView.backgroundColor = UIColor.clearColor()
		
		let arr = Array(self.playlistDictionary.keys)
		let key = arr[section]
		
		let label = UILabel()
		label.font = UIFont(name: Constants.FONT_PROXIMA_NOVA_REGULAR, size: Constants.FONT_SIZE_PLAYLIST_HEADER)
		label.text = key
		//MusicPlayer.sharedPlayer.getHeaderForCurrentMusicMode()//
		label.textAlignment = .Left
		label.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
		headerView.addSubview(label)
		label.sizeToFit()
		label.frame = CGRect(x: Constants.SIDE_PADDING, y: 0, width: headerView.frame.width - (Constants.SIDE_PADDING * 2), height: label.frame.height)
		label.centerVerticallyInSuperView()
		
		let separatorView = UIView(frame: CGRect(x: Constants.SIDE_PADDING, y: (label.frame.maxY + Constants.PADDING), width: headerView.frame.width - (Constants.SIDE_PADDING * 2), height: 1))
		separatorView.backgroundColor = Color.SeparatorColor.uiColor
		headerView.addSubview(separatorView)
		
		return headerView
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCellWithIdentifier(Constants.SONG_PLAYLIST_CELL_IDENTIFIER, forIndexPath: indexPath) as! SongCell
		
		let arr = Array(self.playlistDictionary.keys)
		let key = arr[indexPath.section]
		
		var allSongs: [Song] = self.playlistDictionary[key]!
		
		var song:Song = allSongs[indexPath.row]
		
		//MusicPlayer.sharedPlayer.getNowPlayingList()[indexPath.row]
		
		cell.song = song
		
		//println("table height: \(tableView.contentSize.height)")
		
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
	{
		/*self.songSelected = self.songs[indexPath.row] as Song
		
		MusicPlayer.sharedPlayer.delegate = self.navController
		
		MusicPlayer.sharedPlayer.playSong(self.songSelected!)
		*/
		//self.navController!.toggleMusicPlayer()
		
		//	APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.Band, delegate: self, parameters: nil, appendedString: "\(self.songSelected!.band.bandID)")
	}
	
	// MARK: MusicPlayer Delegate Methods
	func musicPlayerDidUpdateTimeCode(musicPlayer: MusicPlayer, current: CMTime, total: CMTime)
	{
		let currentTotal = Int(CMTimeGetSeconds(current))
		
		let completeTotal = Float(CMTimeGetSeconds(total))
		
		let minutes = floorf(Float(currentTotal / 60))
		let seconds = floorf(Float(currentTotal % 60))
		
		self.musicPlayerView.time.text = String(format: "%02.0f:%02.0f", minutes, seconds) //"\(minutes) : \(seconds)"
		
		let totalMinutes = floorf(Float(completeTotal / 60))
		let totalSeconds = floorf(Float(completeTotal % 60))
		
		self.musicPlayerView.totalTime.text = String(format: "%02.0f:%02.0f", totalMinutes, totalSeconds)
		
		// calculate indicator width
		let indicatorPercent = Float(currentTotal) / completeTotal
		
		//self.musicPlayerView.setPercent(CGFloat(indicatorPercent))
		
		
		//	println("total: \(completeTotal) current total: \(currentTotal) minutes: \(minutes) seconds: \(seconds) indicator percent: \(indicatorPercent)")
	}
	
	func musicPlayerDidStartPlaying(musicPlayer: MusicPlayer, song: Song)
	{
		//self.toggleMusicPlayer()
		
		//self.musicPlayerView.togglePlayButton()
		
		//self.musicPlayerView.song = song
	}
	
	func musicPlayerDidToggle(musicPlayer: MusicPlayer)
	{
		//self.musicPlayerView.togglePlayButton()
	}
	
	func musicPlayerSongDidEnd(musicPlayer: MusicPlayer)
	{
		
	}
	
	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject?)
	{
		super.apiManagerDidReturnData(apiManager, data: data)
		
		/*
		var dataDict:NSDictionary = data as! NSDictionary
		
		var songArray:NSArray = dataDict["songs"] as! NSArray
		
		var songs = [Song]()
		
		for eachSong in songArray
		{
			var song = Song(dict:eachSong as! NSDictionary)
			songs.append(song)
		}
		
		switch apiManager.apiRequest!
		{
			case .Hot:
				self.playlistDictionary.insert(songs, forKey: Constants.KEY_HOT_CHARTS, atIndex: 0)
				
				APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.Discovery, delegate: self)
				break
			
			case .Discovery:
				self.playlistDictionary.insert(songs, forKey: Constants.KEY_QUEUE, atIndex: 1)
				self.playerTableView.reloadData()
				break
			
			default:
			
				break
		}*/
	}

}
