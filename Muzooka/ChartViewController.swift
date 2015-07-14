//
//  ViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/4/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit
import AVFoundation

class ChartViewController: MuzookaViewController, UITableViewDataSource, UITableViewDelegate, MuzookaCellDelegate
{
	var songs = [Song]()
	
	var chartType: ChartType = .Hot
	
	@IBOutlet var songTableView: UITableView!

	override func viewDidLoad()
	{
		super.viewDidLoad()
	}
	
	override func loadData()
	{
		super.loadData()
		
		self.setSelectedIndex(self.chartType.rawValue)
	}
	
	override func setSelectedIndex(index: Int)
	{
		self.songs.removeAll()
		self.songTableView.reloadData()
		
		var apiRequest = APIRequest(requestType: APIRequest.RequestType(rawValue: index)!, requestParameters: nil)
		let referrer = apiRequest.buildReferrerWithAppendedIDAndExtraInfo(0, extraInfo: "")
		//var paramDict = NSDictionary(objectsAndKeys: 10, "offset", Constants.TOTAL_QUEUE_COUNT, "count")
		APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, apiReferrer: referrer)//, parameters: nil, appendedString: "", offset: 10, count: 20)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	// MARK: - Table View
	func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return self.songs.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCellWithIdentifier(Constants.SONG_CELL_IDENTIFIER, forIndexPath: indexPath) as! SongCell
		
		var song = self.songs[indexPath.row]
		
		cell.song = song
		
		cell.rank.text = "\(indexPath.row + 1)"
		cell.cellDelegate = self
		//cell.voteButton.tag = indexPath.row
		//cell.menuButton.tag = indexPath.row
		
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
	{
		self.itemSelected = self.songs[indexPath.row] as Song

		MusicPlayer.sharedPlayer.delegate = self.navController
		
		var nowPlayingSlice: ArraySlice<Song> = self.songs[0..<Constants.TOTAL_QUEUE_COUNT]
		var nowPlayingArray: [Song] = Array(nowPlayingSlice)
		
		MusicPlayer.sharedPlayer.addSongsToQueue(nowPlayingArray, mode: MusicPlayer.Mode(rawValue:self.chartType.rawValue)!, playIndex: indexPath.row)
		
		//MusicPlayer.sharedPlayer.playSong(self.songSelected!)
		
		//self.navController!.toggleMusicPlayer()

		//	APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.Band, delegate: self, parameters: nil, appendedString: "\(self.songSelected!.band.bandID)")
	}
	
	// MARK: - Muzooka Cell Delegate
	func cellRequestedShowMenu(cell: UITableViewCell, item: AnyObject)
	{
		self.itemSelected = item as! Song
		
		self.showActionMenuWithTitle(self.itemSelected!.getItemName())
	}
	
	func cellRequestedAction(cell: UITableViewCell, item: AnyObject)
	{
		let song = item as! Song
		
		if song.userVoted == true
		{
			let apiRequest = APIRequest(requestType: APIRequest.RequestType.UnVoteSong, requestParameters: [APIRequestParameter(key: "", value: "\(song.songID)")])
			APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, postData: nil)
			/*MZSongOperations.upvoteSong(searchItem.song?.songID, callback:
			{ (Bool result) -> Void in
			
			})*/
		}
		else
		{
			let apiRequest = APIRequest(requestType: APIRequest.RequestType.UnVoteSong, requestParameters: [APIRequestParameter(key: "", value: "\(song.songID)")])
			APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, postData: nil)
		}
		
		self.itemSelected = song
	}
	
	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject?)
	{
		super.apiManagerDidReturnData(apiManager, data: data)
		
		switch apiManager.apiRequest!.requestType
		{
			case APIRequest.RequestType.VoteSong:
				
				
				break
			
			/*case APIRequest.Band:
				var dataDict:NSDictionary = data as! NSDictionary
				
				var band = Band(dict: dataDict)
				
				var avc = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.ARTIST_VIEW_CONTROLLER) as! ArtistViewController
				self.presentViewController(avc, animated: true, completion:
				{ () -> Void in
					avc.band = band
				})
				break*/
			
			default:
				var dataDict:NSDictionary = data as! NSDictionary
				var songArray:NSArray = dataDict["songs"] as! NSArray
				
				for eachSong in songArray
				{
					var song = Song(dict:eachSong as! NSDictionary)
					self.songs.append(song)
				}
				
				self.songTableView.reloadData()
				
				break
		}
	}
	
}

