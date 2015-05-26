//
//  ViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/4/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class ChartViewController: MuzookaViewController, UITableViewDataSource, UITableViewDelegate
{
	var songs = [Song]()
	
	var songSelected: Song?
	
	@IBOutlet var songTableView: UITableView!

	override func viewDidLoad()
	{
		super.viewDidLoad()
	}
	
	override func loadData()
	{
		super.loadData()
		
		self.setSelectedIndex(APIRequest.Hot.rawValue)
	}
	
	@IBAction func voteForSong(sender: UIButton)
	{
		var index = sender.tag
		
		var song = self.songs[index] as Song
		
		var paramDict = NSDictionary(objectsAndKeys: "\(song.songID)", "song_id")//"Jen", "name", "jenduf2", "username", "jenduf3@gmail.com", "email", "Duff0818", "password")
		
		APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.VoteSong, delegate: self, parameters: paramDict)
	}
	
	@IBAction func showMenu(sender: UIButton)
	{
		var index = sender.tag
		
		self.songSelected = self.songs[index] as Song
		
		let alertController = UIAlertController(title: "\(self.songSelected!.name) - \(self.songSelected!.band.name)", message: "", preferredStyle: .ActionSheet)
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel)
		{ (action) -> Void in
			//
		}
		
		alertController.addAction(cancelAction)
		
		for menuItem in SongMenu.songMenuValues
		{
			var action = UIAlertAction(title: menuItem.title, style: .Default, handler:
			{ (action) -> Void in
				
				self.performActionForType(menuItem)
			})
			
			alertController.addAction(action)
		}
		
		self.presentViewController(alertController, animated: true)
		{ () -> Void in
			//
		}
	}
	
	override func setSelectedIndex(index: Int)
	{
		self.songs.removeAll()
		self.songTableView.reloadData()
		
		var apiRequest = APIRequest(rawValue: index)
		APIManager.sharedManager.getAPIRequestForDelegate(apiRequest!, delegate: self)
	}
	
	// MARK: - Helpers
	func performActionForType(menuItem: SongMenu)
	{
		switch menuItem
		{
			case .PlayLater:
				println("play later")
				
				break
			
			case .SongInfo:
				let sivc = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.SONG_INFO_VIEW_CONTROLLER) as! SongInfoViewController
				self.navController?.navigateToController(sivc)
				sivc.songID = "\(self.songSelected!.songID)"
				
				break
			
			case .ArtistInfo:
				let avc = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.ARTIST_VIEW_CONTROLLER) as! ArtistViewController
				self.navController?.navigateToController(avc)
				avc.bandID = "\(self.songSelected!.band.bandID)"
				
				break
			
			case .AddToPlaylist:
				let pvc = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.PLAYLIST_VIEW_CONTROLLER) as! PlaylistViewController
				self.navController?.navigateToController(pvc)
				
				break
			
			case .Share:
				var str = "string"
				var url = NSURL(string: "www.yahoo.com")
				let objectsToShare = NSArray(objects: str, url!)
				var activityVC = UIActivityViewController(activityItems: objectsToShare as [AnyObject], applicationActivities: nil)
				self.presentViewController(activityVC, animated: true, completion:
				{ () -> Void in
					
				})
				
				break
		}
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
		cell.voteButton.tag = indexPath.row
		cell.menuButton.tag = indexPath.row
		
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
	{
		self.songSelected = self.songs[indexPath.row] as Song

		//	APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.Band, delegate: self, parameters: nil, appendedString: "\(self.songSelected!.band.bandID)")
	}
	
	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject)
	{
		super.apiManagerDidReturnData(apiManager, data: data)
		
		switch apiManager.apiRequest!
		{
			case APIRequest.VoteSong:
				
				
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
				var songArray:NSArray = data["songs"] as! NSArray
				
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

