//
//  ProfileViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/6/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class ProfileViewController: MuzookaViewController, UITableViewDataSource, UITableViewDelegate
{
	@IBOutlet var bannerView: BannerView!
	@IBOutlet var playlistTableView: UITableView!
	@IBOutlet var followers: UILabel!
	@IBOutlet var following: UILabel!
	@IBOutlet var likes: UILabel!
	
	
	var user: User?
	{
		didSet
		{
			self.bannerView.user = user
			
			self.followers.text = "\(user!.followersCount)"
			
			self.following.text = "\(user!.followingCount)"
			
			self.likes.text = "\(user!.likesCount)"
		}
	}
	
	
	override func loadData()
	{
		super.loadData()
		
		let apiRequest = APIRequest(requestType: APIRequest.RequestType.UserDetails, requestParameters: [APIRequestParameter(key: "", value: "\(User.currentUser.userID)")])
		
		APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, postData: nil)
	}

	override func viewDidLoad()
	{
		super.viewDidLoad()
	}
	
	@IBAction func editProfile(sender: AnyObject)
	{
		self.navController!.navigateToControllerWithIdentifier(Constants.EDIT_PROFILE_VIEW_CONTROLLER)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: - Table View
	func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
		return User.currentUser.playlistDictionary.count
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		let (key, playlists) = User.currentUser.playlistDictionary[section]
		
		return playlists.count
	}
	
	/*
	func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
	{
		return User.currentUser.playlistDictionary.getKeyForIndex(section)
	}*/
	
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
	{
		var headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: Constants.TABLE_HEADER_HEIGHT))
		headerView.backgroundColor = Color.OffWhite.uiColor
		
		let label = UILabel()
		label.font = UIFont(name: Constants.FONT_PROXIMA_NOVA_SEMIBOLD, size: Constants.FONT_SIZE_TABLE_HEADER)
		label.text = User.currentUser.playlistDictionary.getKeyForIndex(section)
		label.textAlignment = .Left
		label.textColor = Color.TextDark.uiColor
		headerView.addSubview(label)
		label.sizeToFit()
		label.frame = CGRect(x: Constants.PADDING, y: 0, width: headerView.frame.width - (Constants.PADDING * 2), height: label.frame.height)
		label.centerVerticallyInSuperView()
		
		return headerView
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCellWithIdentifier(Constants.PROFILE_PLAYLIST_CELL_IDENTIFIER, forIndexPath: indexPath) as! PlaylistTableCell
		
		let (key, playlists) = User.currentUser.playlistDictionary[indexPath.section]
		
		var playlist = playlists[indexPath.row] as Playlist
		
		cell.playlist = playlist as Playlist
		
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
		
		switch apiManager.apiRequest!.requestType
		{
			case .UserDetails:
				var dict:NSDictionary = data as! NSDictionary
				
				var user = User(dict: dict)
				
				User.currentUser = user
				
				self.playlistTableView.reloadData()
				
				break
			
			default:
			
				break
		}
		
		
	}

}
