//
//  ArtistViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/13/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class ArtistViewController: MuzookaViewController, UITableViewDataSource, UITableViewDelegate, BandInfoCellDelegate, SegmentViewDelegate, MuzookaCellDelegate
{
	@IBOutlet var artistName: UILabel!
	@IBOutlet var artistLocation: UILabel!
	@IBOutlet var artistTableView: UITableView!
	@IBOutlet var albumArtView: AlbumArtView!
	@IBOutlet var segmentView: SegmentView!
	@IBOutlet var aboutView: UIView!
    
    var newHeight: CGFloat = 0
	
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
            
            let imageURL = ImageDimension.Medium.getImageDimensionAtURL(band!.bannerURL!) as String
            
            self.albumArtView.artURL = band?.banner
			
			self.artistTableView.reloadData()
		}
	}

	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		//self.segmentView.updateSegments(["Songs", "About"])
		
		self.segmentView.delegate = self
	}
	
	override func loadData()
	{
		let apiRequest = APIRequest(requestType: APIRequest.RequestType.Band, requestParameters: [APIRequestParameter(key: "", value: self.bandID!)])
		
		APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, postData: nil)
	
	}
    
    func getNumberOfRowsForSection(section: Int) -> Int
    {
        let bSection = BandSection(rawValue: section)
        
        switch bSection!
        {
            case .About:
                return 1
                
            case .Bio:
                return 1
                
            case .Members:
                if self.band != nil
                {
                    return self.band!.bandMembers.count
                }
                
            case .Social:
                var socialRowCount = 0
                if self.band?.facebookUserName != nil
                {
                    socialRowCount++
                }
                
                if self.band?.twitterUserName != nil
                {
                    socialRowCount++
                }
                
                if self.band?.googleUserName != nil
                {
                    socialRowCount++
                }
                
                return socialRowCount
        }
        
        return 0
    }
    
    func heightForSection(section: Int) -> CGFloat
    {
        let bSection = BandSection(rawValue: section)
        
        switch bSection!
        {
            case .About:
                return Constants.BAND_INFO_CELL_HEIGHT
                
            case .Bio:
                if self.newHeight > 0
                {
                    return self.newHeight + Constants.BAND_BIO_CELL_HEIGHT
                }
                else
                {
                    let size = CGSize(width: UIScreen.mainScreen().bounds.width - (Constants.SIDE_PADDING * 2), height: CGFloat.max)
                    
                    let rowSize = Utils.getCellHeightForFont(UIFont(name: Constants.FONT_PROXIMA_NOVA_SEMIBOLD, size: Constants.FONT_SIZE_BIO_CELL)!, text: self.band!.bio!, bounds: size)
                    return min(rowSize.height + Constants.BAND_PADDING_HEIGHT, Constants.BAND_BIO_CELL_HEIGHT)
                }
                
            case .Members:
                return Constants.BAND_INFO_CELL_HEIGHT
                
            case .Social:
                return Constants.BAND_INFO_CELL_HEIGHT
        }
    }
    
    func socialInfoForSection(section: Int) -> String?
    {
        let sSection = SocialSection(rawValue: section)
        
        switch sSection!
        {
            case .Facebook:
                return self.band?.facebookUserName
                
            case .Twitter:
                return self.band?.twitterUserName
                
            case .Email:
                return self.band?.webSite
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        if self.segmentView.selectedIndex == 0
        {
            return 1
        }
        
        return BandSection.sections.count //self.songInfoDictionary.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        /*let arr = Array(self.songInfoDictionary.keys)
        let key = arr[section]
        
        let votes = self.songInfoDictionary[key]
        
        return votes!.count*/
        
        if self.segmentView.selectedIndex == 0
        {
            if self.band != nil
            {
                return self.band!.songs.count
            }
        }
        
        return self.getNumberOfRowsForSection(section)
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if self.segmentView.selectedIndex == 0
        {
            return ""
        }
        
        let bSection = BandSection(rawValue: section)
        return bSection!.stringValue()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if self.segmentView.selectedIndex == 0
        {
            return Constants.BAND_SONG_CELL_HEIGHT
        }
        
        return self.heightForSection(indexPath.section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if self.segmentView.selectedIndex == 0
        {
            let song = self.band?.songs[indexPath.row]
            
            let cell = tableView.dequeueReusableCellWithIdentifier(Constants.BAND_INFO_SONG_CELL_IDENTIFIER) as! SongCell
            cell.cellDelegate = self
            
            if song != nil
            {
                cell.song = song
            }
            
            return cell
        }
        
        let bSection = BandSection(rawValue: indexPath.section)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(bSection!.getCellIdentifierForSection()) as! BandInfoCell
        cell.bandInfoCellDelegate = self
        cell.band = self.band
        
        if bSection == .Members
        {
            let member = self.band?.bandMembers[indexPath.row]
            cell.bandMember = member
        }
        else if bSection == .Social
        {
            let sSection = SocialSection(rawValue: indexPath.row)
            cell.socialImage.image = UIImage(named: sSection!.stringValue())
            
            cell.socialLabel.text = self.socialInfoForSection(indexPath.row)
        }
        
        return cell
    }
    
    // MARK: - Muzooka Cell Delegate
    func cellRequestedShowMenu(cell: UITableViewCell, item: AnyObject)
    {
        self.itemSelected = item as! Song
        
        self.showActionMenuWithTitle(self.itemSelected!.getItemName())
    }
    
    func cellRequestedAction(cell: UITableViewCell, item: AnyObject)
    {
        var song = item as! Song
        
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
	
	// MARK: Segment View Delegate Methods
	func segmentViewDidSelectViewIndex(segmentView: SegmentView, index: Int)
	{
		self.artistTableView.reloadData()
	}
    
    // MARK: Band Info Cell Delegate Methods
    func bandInfoCellRequestedReadMore(cell: BandInfoCell, rect: CGRect)
    {
        self.newHeight = rect.size.height
        
        self.artistTableView.reloadData()
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
