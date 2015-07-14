//
//  ArtistViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/13/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class ArtistViewController: MuzookaViewController, UITableViewDataSource, UITableViewDelegate, SegmentViewDelegate
{
	@IBOutlet var artistName: UILabel!
	@IBOutlet var artistLocation: UILabel!
	@IBOutlet var artistTableView: UITableView!
	@IBOutlet var artistBanner: UIImageView!
	@IBOutlet var segmentView: SegmentView!
	@IBOutlet var aboutView: UIView!
	
	var bandID: String?
	{
		didSet
		{
			self.loadData()
		}
	}
	
	var band: Band?
	{
		didSet
		{
			self.artistName.text = band!.name
			self.artistLocation.text = band!.city
			
			/*
			let request = NSURLRequest(URL: NSURL(string: band!.avatar!)!)
			NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
			{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
					let image = UIImage(data: data)
					self.artistBanner.image = image
			}*/
			
			self.artistBanner.loadFromURL(NSURL(string: band!.getImageURLForDimension(.Medium, url: band!.bannerURL!))!)
			
			self.artistTableView.reloadData()
		}
	}

	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		self.segmentView.updateSegments(["Songs", "About"])
		
		self.segmentView.delegate = self
	}
	
	override func loadData()
	{
		let apiRequest = APIRequest(requestType: APIRequest.RequestType.Band, requestParameters: [APIRequestParameter(key: "", value: self.bandID!)])
		
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
		if self.band != nil
		{
			return self.band!.songs.count
		}
		
		return 0
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCellWithIdentifier(Constants.ARTIST_SONG_CELL_IDENTIFIER, forIndexPath: indexPath) as! SongCell
		
		var song = self.band!.songs[indexPath.row]
		
		cell.song = song
		cell.voteButton.tag = indexPath.row
		
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
	{
		var song = self.band!.songs[indexPath.row] as Song
		
		//APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.Band, delegate: self, parameters: nil, appendedString: "/\(song.band.bandID)")
	}
	
	// MARK: Segment View Delegate Methods
	func segmentViewDidSelectViewIndex(segmentView: SegmentView, index: Int)
	{
		
	}
	
	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject?)
	{
		super.apiManagerDidReturnData(apiManager, data: data)
		
		switch apiManager.apiRequest!
		{
			default:
				var dataDict:NSDictionary = data as! NSDictionary
				
				self.band = Band(dict: dataDict)
				
				break
		}
	}

}
