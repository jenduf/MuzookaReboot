//
//  PlaylistViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class PlaylistViewController: MuzookaViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIAlertViewDelegate
{
	var playlists = [Playlist]()
	
	@IBOutlet var playlistCollectionView: UICollectionView!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		self.loadData()
	}
	
	override func loadData()
	{
		super.loadData()
		
		if User.currentUser != nil
		{
			APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.PersonalPlaylists, delegate: self, parameters: nil, appendedString: "\(User.currentUser.userID)")
		}
	}
	
	override func performButtonActionType(type: NavButtonType)
	{
		var alertView: UIAlertView = UIAlertView(title: "New Playlist", message: "", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
		alertView.alertViewStyle = UIAlertViewStyle.PlainTextInput
		alertView.show()
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: UICollectionViewDataSource
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return self.playlists.count
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.PLAYLIST_CELL_IDENTIFIER, forIndexPath: indexPath) as! PlaylistCell
		
		let playlist = self.playlists[indexPath.row]
		
		cell.playlist = playlist
		
		return cell
	}
	
	// MARK: UICollectionViewDelegate
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
	{
		let playlist = self.playlists[indexPath.row]
		
		var pdvc = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.PLAYLIST_DETAIL_VIEW_CONTROLLER) as! PlaylistDetailViewController
		pdvc.playlistID = "\(playlist.playlistID)"
		
		self.navController!.navigateToController(pdvc)
	}
	
	// MARK: Alert View Delegate Methods
	func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
	{
		var playlistName = alertView.textFieldAtIndex(0)!.text
		
		var paramDict = NSDictionary(objectsAndKeys: playlistName, "name")
		APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.CreatePlaylist, delegate: self, parameters: paramDict)
	}
    

	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject)
	{
		super.apiManagerDidReturnData(apiManager, data: data)
		
		switch apiManager.apiRequest!
		{
			case .PersonalPlaylists:
				self.playlists.removeAll()
				
				var playlistArray:NSArray = data["playlists"] as! NSArray
				
				for eachPlaylist in playlistArray
				{
					var playlist = Playlist(dict:eachPlaylist as! NSDictionary)
					self.playlists.append(playlist)
				}
				
				self.playlistCollectionView.reloadData()
			
				break
			
			case .CreatePlaylist:
				self.loadData()
				break
			
			default:
			
				break
		}
		
		
	}

}
