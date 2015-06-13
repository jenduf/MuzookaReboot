//
//  SearchDetailViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/1/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class SearchDetailViewController: MuzookaViewController, UITableViewDataSource, UITableViewDelegate
{
	var searchDetails: SearchDetails?
	
	var filteredResults = [SearchItem]()
	
	@IBOutlet var searchTableView: UITableView!

	override func viewDidLoad()
	{
		super.viewDidLoad()

        // Do any additional setup after loading the view.
	}
	
	override func setSelectedIndex(index: Int)
	{
		self.filteredResults.removeAll()
		
		var type: SearchItemType = SearchItemType.getSearchItemFromInt(index)!
		
		for searchItem in self.searchDetails!.searchItems
		{
			if searchItem.searchItemType == type
			{
				self.filteredResults.append(searchItem)
			}
		}
		
		self.searchTableView.reloadData()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
	}
	
	func getCellIdentifierForType(searchType: SearchItemType) -> String
	{
		switch searchType
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
	
	// MARK: - Table View
	func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		if self.filteredResults.count > 0
		{
			return self.filteredResults.count
		}
		
		return self.searchDetails!.searchItems.count
	}
	
	
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
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
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
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
		
		cell.searchItem = searchItem
		
		return cell
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
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
		
		if searchItem.searchItemType == .Band
		{
			return Constants.BAND_CELL_HEIGHT
		}
		
		return Constants.SEARCH_CELL_HEIGHT
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
