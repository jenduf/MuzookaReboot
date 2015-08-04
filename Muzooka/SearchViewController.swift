//
//  SearchViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class SearchViewController: MuzookaViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, SegmentViewDelegate, MuzookaCellDelegate
{
	//@IBOutlet var searchingView: UIView!
	
	@IBOutlet var searchHeightConstraint: NSLayoutConstraint!
	@IBOutlet var searchTrailingConstraint: NSLayoutConstraint!

	@IBOutlet var searchTableView: UITableView!
	
	@IBOutlet var searchView: UIView!
	
	@IBOutlet var searchTextView: UIView!
	
	@IBOutlet var searchTextField: UITextField!
	
	@IBOutlet var searchButton: BorderedButton!
	
	@IBOutlet var segmentView: SegmentView!
	
	var searchDetails: SearchDetails?
	
	var filteredResults = [SearchItem]()
	
    

	override func viewDidLoad()
	{
        super.viewDidLoad()
		
		self.searchTextField.tintColor = Color.SearchTint.uiColor
		
		self.segmentView.delegate = self
		
		self.segmentView.updateSegments(NavScreen.SearchDetail.subHeadings)

		//var textFieldInSearchBar = self.searchBar.valueForKey("searchField") as? UITextField
		//textFieldInSearchBar?.textColor = Color.SearchTextColor.uiColor
		
		//self.searchBar.setImage(UIImage.new(), forSearchBarIcon: UISearchBarIcon.Search, state: UIControlState.Normal)
		
		//self.searchView.backgroundColor = Color.SearchBackgroundColor.uiColor
	}
	
	override func loadData()
	{
		let searchItem = self.searchTextField.text
		
		if !searchItem.isEmpty
		{
			//self.searchingView.hidden = false
			
			//SearchController.sharedController.searchForItem(searchItem)
			
			let apiRequest = APIRequest(requestType: APIRequest.RequestType.SearchAll, requestParameters: [APIRequestParameter(key: "", value: "\(searchItem)")])
			
			//	let referrer = APIRequest.RequestType.SearchAll.buildReferrerWithAppendedIDAndExtraInfo(0, extraInfo: searchItem)
			APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, apiReferrer: nil, postData: nil)
		}
	}
	
	func showSearchHeader()
	{
		self.navController?.toggleHeader(true)
		
		self.searchTrailingConstraint.constant = (self.searchButton.width + Constants.SIDE_PADDING)
		self.searchTextView.setNeedsUpdateConstraints()
		
		self.searchHeightConstraint.constant = self.segmentView.bottom
		self.searchView.setNeedsUpdateConstraints()
		
		println("segment bottom: \(self.segmentView.bottom)")
		
		
		UIView.animateWithDuration(Constants.SHORT_ANIMATION_DURATION, animations:
		{ () -> Void in
				self.searchView.layoutIfNeeded()
				
				self.searchTextView.layoutIfNeeded()//.frame = CGRect(origin: self.searchTextField.getOrigin(), size: CGSize(width: 50, height: self.searchTextField.getHeight()))
				//self.searchView.setHeight(90)
				//self.searchView.setTop(-(self.searchView.getHeight() / 2))
				//self.searchView.moveBy(CGPoint(x: 0, y: -self.segmentView.getHeight()))
			//	self.segmentView.setTop(self.searchTextView.getBottom() + Constants.PADDING)
			//	self.segmentView.moveBy(CGPoint(x: 0, y: -self.segmentView.getHeight() + Constants.PADDING))
				//self.searchTableView.moveBy(CGPoint(x: 0, y: self.segmentView.getHeight()))
		})
	}
	
	func hideSearchHeader()
	{
		self.navController?.toggleHeader(false)
		
		self.searchTrailingConstraint.constant = Constants.PADDING
		self.searchTextView.setNeedsUpdateConstraints()
		
		self.searchHeightConstraint.constant = (self.searchTextView.bottom + Constants.PADDING)
		self.searchView.setNeedsUpdateConstraints()
		
		UIView.animateWithDuration(Constants.SHORT_ANIMATION_DURATION, animations:
		{ () -> Void in
				self.searchView.layoutIfNeeded()
				
				self.searchTextView.layoutIfNeeded()//.frame = CGRect(origin: self.searchTextField.getOrigin(), size: CGSize(width: 50, height: self.searchTextField.getHeight()))
				//self.searchView.setHeight(90)
				//self.searchView.setTop(-(self.searchView.getHeight() / 2))
				//self.searchView.moveBy(CGPoint(x: 0, y: -self.segmentView.getHeight()))
			//self.segmentView.moveBy(CGPoint(x: 0, y: self.segmentView.getHeight() - Constants.PADDING))
			
				//self.searchTableView.moveBy(CGPoint(x: 0, y: self.segmentView.getHeight()))
		})
		{ (Bool) -> Void in
			//self.segmentView.setTop(self.searchTextView.getBottom() + Constants.PADDING)
			println("segment bottom: \(self.segmentView.bottom)")
			self.searchDetails = nil
			self.searchTableView.reloadData()
		}
	}
	
	func getCellIdentifierForType(type: MediaType) -> String
	{
		switch type
		{
			case .Band:
				return Constants.SEARCH_BAND_CELL_IDENTIFIER
				
			case .Song:
				return Constants.SEARCH_SONG_CELL_IDENTIFIER
				
			case .User:
				return Constants.SEARCH_USER_CELL_IDENTIFIER
				
			case .Playlist:
				return Constants.SEARCH_PLAYLIST_CELL_IDENTIFIER
				
			default:
				break
		}
		
		return ""
	}
	
	func showViewForSearchItem(item: SearchItem)
	{
		switch item.searchItemType!
		{
			case .Band:
				let avc = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.ARTIST_VIEW_CONTROLLER) as! ArtistViewController
				avc.band = item.band
				self.navController?.navigateToController(avc)
				break
				
			case .User:
				let upvc = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.PROFILE_VIEW_CONTROLLER) as! ProfileViewController
				upvc.user = item.user
				self.navigationController?.pushViewController(upvc, animated: true)
				break
				
			case .Playlist:
				let pvc = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.PLAYLIST_VIEW_CONTROLLER) as! PlaylistViewController
				pvc.userID = item.getItemID()!
				self.navController?.navigateToController(pvc)
				break
				
			case .Song:
				//MZSongUtility.updateCachedSong(item.song?.mzSong, silently: true)
				//MZMusicPlayer.playSingleSong(item.getItemID())
				//MZViewControllerUtility.playSong(searchItem.getItemID())
				MusicPlayer.sharedPlayer.addSongToPersonalQueue(item.song!, playNow: true)
				break
			
			default:
			
				break
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func cancel(btn: UIButton?)
	{
		//let searchItem = self.searchTextField.text
		
		//SearchController.sharedController.searchForItem(searchItem)
		
		//	self.showDetailScreen = true
		
		//self.loadData()
		
		self.hideSearchHeader()
		
		self.searchTextField.resignFirstResponder()
	}
    

	// MARK: - Table View
	func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
		return 1
	}
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
	{
		return Constants.TABLE_HEADER_HEIGHT
	}
	
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
	{
		if self.searchDetails != nil
		{
			var headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: Constants.TABLE_HEADER_HEIGHT))
			headerView.backgroundColor = Color.OffWhite.uiColor
			
			let label = UILabel()
			label.font = UIFont(name: Constants.FONT_PROXIMA_NOVA_REGULAR, size: Constants.FONT_SIZE_SEARCH_HEADER)
			
			let count = (self.filteredResults.count > 0 ? self.filteredResults.count : self.searchDetails!.searchItems.count)
			label.text = "\(count) search results for \(self.searchDetails!.searchTerm)"
			label.textAlignment = .Left
			label.textColor = Color.SearchHeaderTextColor.uiColor
			headerView.addSubview(label)
			label.sizeToFit()
			label.frame = CGRect(x: Constants.SIDE_PADDING, y: 0, width: label.frame.width, height: label.frame.height)
			label.centerVerticallyInSuperView()
			
			return headerView
		}
		
		var headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: Constants.TABLE_HEADER_HEIGHT))
		headerView.backgroundColor = Color.OffWhite.uiColor
		
		let label = UILabel()
		label.font = UIFont(name: Constants.FONT_PROXIMA_NOVA_REGULAR, size: Constants.FONT_SIZE_SEARCH_HEADER)
		label.text = Constants.TITLE_RECENTLY_SEARCHED
		label.textAlignment = .Left
		label.textColor = Color.SearchHeaderTextColor.uiColor
		headerView.addSubview(label)
		label.sizeToFit()
		label.frame = CGRect(x: Constants.SIDE_PADDING, y: 0, width: label.frame.width, height: label.frame.height)
		label.centerVerticallyInSuperView()

		return headerView
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		if self.searchDetails != nil
		{
			if self.filteredResults.count > 0
			{
				return self.filteredResults.count
			}
			
			return self.searchDetails!.searchItems.count
		}
		
		return SearchController.sharedController.recentlySearchedItems.count
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
	{
		
		if self.searchDetails != nil
		{
			var searchItem: SearchItem
			
			if self.filteredResults.count > 0
			{
				searchItem = self.filteredResults[indexPath.row] as SearchItem
			}
			else
			{
				searchItem = self.searchDetails!.searchItems[indexPath.row] as SearchItem
			}
			
			if searchItem.searchItemType == MediaType.Band
			{
				return Constants.BAND_CELL_HEIGHT
			}
		}
		
		return Constants.SEARCH_CELL_HEIGHT
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		if self.searchDetails != nil
		{
			var searchItem: SearchItem
			
			if self.filteredResults.count > 0
			{
				searchItem = self.filteredResults[indexPath.row] as SearchItem
			}
			else
			{
				searchItem = self.searchDetails!.searchItems[indexPath.row] as SearchItem
			}
			
			let cell = tableView.dequeueReusableCellWithIdentifier(self.getCellIdentifierForType(searchItem.searchItemType), forIndexPath: indexPath) as! SearchCell
			cell.cellDelegate = self
			
			cell.searchItem = searchItem
			
			return cell
		}
		
		let cell = tableView.dequeueReusableCellWithIdentifier(Constants.SEARCH_CELL_IDENTIFIER, forIndexPath: indexPath) as! SearchCell
		
		var searchItem = SearchController.sharedController.recentlySearchedItems[indexPath.row]
		
		cell.searchText.text = searchItem
		
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
	{
		if self.searchDetails != nil
		{
			var searchItem: SearchItem
			
			if self.filteredResults.count > 0
			{
				searchItem = self.filteredResults[indexPath.row] as SearchItem
			}
			else
			{
				searchItem = self.searchDetails!.searchItems[indexPath.row] as SearchItem
			}
			
			self.showViewForSearchItem(searchItem)
		}
		else
		{
			var searchItem = SearchController.sharedController.recentlySearchedItems[indexPath.row]
			
			self.searchTextField.text = searchItem
			
			self.showSearchHeader()
			
			self.loadData()
		}
	}
	
	// MARK: Text Field Delegate Methods
	func textFieldShouldBeginEditing(textField: UITextField) -> Bool
	{
		self.showSearchHeader()
		
		return true
	}
	
	func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
	{
		if !string.isEmpty
		{
			self.loadData()
			
			//self.searchButton.enabled = true
		}
		
		return true
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool
	{
		if !textField.text.isEmpty
		{
			SearchController.sharedController.searchForItem(textField.text)
			
			self.loadData()
		}
		
		return true
	}
	
	// MARK: - Search Cell Delegate
	func cellRequestedShowMenu(cell: UITableViewCell, item: AnyObject)
	{
		let searchItem = item as! SearchItem
		self.itemSelected = searchItem.getShareableItem()
		
		self.showActionMenuWithTitle(self.itemSelected!.getItemName())
	}
	
	func cellRequestedAction(cell: UITableViewCell, item: AnyObject)
	{
		let searchItem = item as! SearchItem
		
		switch searchItem.searchItemType!
		{
		case .Song:
			if searchItem.song?.userVoted == true
			{
				let apiRequest = APIRequest(requestType: APIRequest.RequestType.UnVoteSong, requestParameters: [APIRequestParameter(key: "", value:  "\(searchItem.getItemID())")])
				APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, postData: nil)
			}
			else
			{
				let apiRequest = APIRequest(requestType: APIRequest.RequestType.VoteSong, requestParameters: [APIRequestParameter(key: "", value:  "\(searchItem.getItemID())")])
				APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, postData: nil)
			}
			
			break
			
		default:
			break
		}
		
		
		//MZSongOperations.upvoteSong(searchItem.song?.songID, callback:
		//{ (Bool result) -> Void in
	}
	
	// MARK: SegmentView Delegate Methods
	func segmentViewDidSelectViewIndex(segmentView: SegmentView, index: Int)
	{
		self.filteredResults.removeAll()
		
		var type: MediaType = MediaType.getItemFromInt(index)
		
		for searchItem in self.searchDetails!.searchItems
		{
			if searchItem.searchItemType == type
			{
				self.filteredResults.append(searchItem)
			}
		}
		
		self.searchTableView.reloadData()
	}
	
	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject?)
	{
		//super.apiManagerDidReturnData(apiManager, data: data)
		
		//self.searchingView.hidden = true
		
		self.searchDetails = nil
		
		
		var items = [SearchItem]()
		
		var dataDict:NSDictionary = data as! NSDictionary
		
		var dataArray: NSArray = dataDict["results"] as! NSArray
		
		for item in dataArray
		{
			var searchItem = SearchItem(dict: item as! NSDictionary)
			items.append(searchItem)
		}
		
			//let sdvc = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.SEARCH_DETAIL_VIEW_CONTROLLER) as! SearchDetailViewController
		self.searchDetails = SearchDetails(term: self.searchTextField.text, items: items)
			//sdvc.searchDetails = searchDetails
			//self.navController!.navigateToController(sdvc)
		
		self.searchTableView.reloadData()
	}

}
