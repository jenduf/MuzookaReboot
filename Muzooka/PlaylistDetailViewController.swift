//
//  PlaylistDetailViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/26/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class PlaylistDetailViewController: MuzookaViewController, UITableViewDataSource, UITableViewDelegate
{

	var songs = [Song]()
	
	@IBOutlet var detailTableView: UITableView!
	
	var playlistID: String?
	
	override func viewDidLoad()
	{
		super.viewDidLoad()

		self.loadData()
	}
	
	override func loadData()
	{
		super.loadData()
		
		let apiRequest = APIRequest(requestType: APIRequest.RequestType.PlaylistDetails, requestParameters: nil)
		
		APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, postData: nil)
		
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
		let cell = tableView.dequeueReusableCellWithIdentifier(Constants.PLAYLIST_SONG_CELL_IDENTIFIER, forIndexPath: indexPath) as! SongCell
		
		var song = self.songs[indexPath.row]
		
		cell.song = song
		
		cell.rank.text = "\(indexPath.row + 1)"
		//cell.voteButton.tag = indexPath.row
		cell.menuButton.tag = indexPath.row
		
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
	{
		//self.songSelected = self.songs[indexPath.row] as Song
		
		//	APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.Band, delegate: self, parameters: nil, appendedString: "\(self.songSelected!.band.bandID)")
	}
	
	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject?)
	{
		super.apiManagerDidReturnData(apiManager, data: data)
		
		var dataDict:NSDictionary = data as! NSDictionary
		
		var songArray:NSArray = dataDict["songs"] as! NSArray
			
		for eachSong in songArray
		{
			var song = Song(dict:eachSong as! NSDictionary)
			self.songs.append(song)
		}
			
		self.detailTableView.reloadData()
	}

}
