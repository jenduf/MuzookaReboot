//
//  SearchViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class SearchViewController: MuzookaViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate
{
	@IBOutlet var searchTableView: UITableView!
	@IBOutlet var searchBar: UISearchBar!
	
	@IBOutlet var searchingView: UIView!
	
	@IBOutlet var searchButton: BorderedButton!
	
	var showDetailScreen: Bool = false
	
	var searchItems = [SearchItem]()
	

    override func viewDidLoad()
	{
        super.viewDidLoad()

		var textFieldInSearchBar = self.searchBar.valueForKey("searchField") as? UITextField
		textFieldInSearchBar?.textColor = Color.SearchTextColor.uiColor
		
		self.searchBar.setImage(UIImage.new(), forSearchBarIcon: UISearchBarIcon.Search, state: UIControlState.Normal)
    }
	
	override func loadData()
	{
		let searchItem = self.searchBar.text
		
		if !searchItem.isEmpty
		{
			self.searchingView.hidden = false
		
			let referrer = APIRequest.SearchAll.buildReferrerWithAppendedIDAndExtraInfo(0, extraInfo: searchItem)
			APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.SearchAll, delegate: self, apiReferrer: referrer, parameters: nil, appendedString: "\(searchItem)")
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func search(btn: UIButton)
	{
		let searchItem = self.searchBar.text
		
		SearchController.sharedController.searchForItem(searchItem)
		
		self.showDetailScreen = true
		
		self.loadData()
	}
    

	// MARK: - Table View
	func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		if self.searchItems.count > 0
		{
			return self.searchItems.count
		}
		
		return SearchController.sharedController.recentlySearchedItems.count
	}
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
	{
		if self.searchItems.count == 0
		{
			return Constants.TABLE_HEADER_HEIGHT
		}
		
		return 0
	}
	
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
	{
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
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		if self.searchItems.count == 0
		{
			let cell = tableView.dequeueReusableCellWithIdentifier(Constants.SEARCH_CELL_IDENTIFIER, forIndexPath: indexPath) as! SearchCell
		
			var searchItem = SearchController.sharedController.recentlySearchedItems[indexPath.row]
		
			cell.searchText.text = searchItem
		
			return cell
		}
		
		let cell = tableView.dequeueReusableCellWithIdentifier(Constants.SEARCH_ITEM_CELL_IDENTIFIER, forIndexPath: indexPath) as! SearchCell
		
		var searchItem = self.searchItems[indexPath.row]
		
		cell.searchItem = searchItem
		
		return cell
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
	{
		
		if self.searchItems.count == 0
		{
			return tableView.rowHeight
		}
		
		return Constants.SEARCH_CELL_HEIGHT
	}
	
	// MARK: Search Bar Delegate Methods
	func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
	{
		if !text.isEmpty
		{
			self.loadData()
			
			self.searchButton.enabled = true
		}
		
		return true
	}
	
	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject)
	{
		//super.apiManagerDidReturnData(apiManager, data: data)
		
		self.searchingView.hidden = true
		
		self.searchItems.removeAll()
		
		var dataDict:NSDictionary = data as! NSDictionary
		
		var dataArray: NSArray = dataDict["results"] as! NSArray
		
		for item in dataArray
		{
			var searchItem = SearchItem(dict: item as! NSDictionary)
			self.searchItems.append(searchItem)
		}
		
		if self.showDetailScreen == false
		{
			self.searchTableView.reloadData()
		}
		else
		{
			let sdvc = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.SEARCH_DETAIL_VIEW_CONTROLLER) as! SearchDetailViewController
			let searchDetails = SearchDetails(term: self.searchBar.text, items: self.searchItems)
			sdvc.searchDetails = searchDetails
			self.navController!.navigateToController(sdvc)
		}
	}

}
