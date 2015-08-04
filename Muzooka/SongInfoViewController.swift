//
//  SongInfoViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/15/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class SongInfoViewController: MuzookaViewController, SegmentViewDelegate
{
    @IBOutlet var segmentView: SegmentView!
    
    @IBOutlet var songLikesTableView: UITableView!
    
    @IBOutlet var songInfoView: SongInfoView!
    
    @IBOutlet var songName: UILabel!
    @IBOutlet var artistName: UILabel!
    
    @IBOutlet var albumArtView: AlbumArtView!
    
    @IBOutlet var playPauseButton: UIButton!
    
    @IBOutlet var tagCollectionView: UICollectionView!
    
    @IBOutlet var songInfoScrollView: UIScrollView!
    
    var song: Song?
    
    
    var songInfoDictionary = [String: [Vote]]()
	

	override func viewDidLoad()
	{
        super.viewDidLoad()

        self.songName.text = self.song!.name
        self.artistName.text = self.song!.band.name
        self.albumArtView.artURL = self.song!.artwork!
        self.albumArtView.showDarkerVersion = true
        
        //self.playPauseButton.selected = MZMusicPlayer.isPlaying()
        
        self.segmentView.delegate = self
        
        self.songInfoScrollView.contentSize = CGSize(width: self.songInfoScrollView.width, height: self.songInfoView.graphView.bottom)
	}
	
	override func loadData()
	{
		super.loadData()
		
		let apiRequest = APIRequest(requestType: APIRequest.RequestType.SongDetails, requestParameters: [APIRequestParameter(key: "", value: "\(self.song!.songID)")])
		
		APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, postData: nil) //appendedString: "\(self.songID!)")
	}
	
    /*
	func setupGraphDisplay()
	{
		// Use 7 days for graph - can use any number,
		// but labels and sample data are set up for 7 days
		let noOfDays:Int = 7
		
		// set up labels
		// day of week labels are set up in storyboard with tags
		// today is last day of the array need to go backwards
		
		self.graphView.setNeedsDisplay()
		
		// get today's day number
		let dateFormatter = NSDateFormatter()
		let calendar = NSCalendar.currentCalendar()
		let componentOptions:NSCalendarUnit = .CalendarUnitWeekday
		let components = calendar.components(componentOptions, fromDate: NSDate())
		
		var weekday = components.weekday
		
		let days = ["S", "S", "M", "T", "W", "T", "F"]
		
		// set up the day name labels with correct day
		for i in reverse(1...days.count)
		{
			if let labelView = self.graphView.viewWithTag(i) as? UILabel
			{
				if weekday == 7
				{
					weekday = 0
				}
				
				labelView.text = days[weekday--]
				
				if weekday < 0
				{
					weekday = days.count - 1
				}
			}
		}
		
		// update graph data
		self.graphView.graphPoints = self.song!.hotChartDays
	}
*/
    @IBAction func close(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion:
            { () -> Void in
                
        })
    }
    
    @IBAction func togglePlay(sender: AnyObject)
    {
        self.playPauseButton.selected = !self.playPauseButton.selected
        
        // MusicPlayerController.sharedPlayer.togglePlay()
        
        /*  var songs = [Song]()
        songs.append(self.song!)
        MusicPlayerController.sharedPlayer.addSongsToQueue(songs, mode: MusicPlayerController.Mode.Playlist, playIndex: 0)
        
        self.toggleMusicPlayer()*/
        
       // if MZMusicPlayer.isPlaying()
        //{
          //  MZMusicPlayer.togglePlay()
        //}
       // else
        //{
          //  MZMusicPlayer.playSingleSong(self.song?.songID)
        //}
    }
    
    // MARK: - Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return self.songInfoDictionary.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let arr = Array(self.songInfoDictionary.keys)
        let key = arr[section]
        
        let votes = self.songInfoDictionary[key]
        
        return votes!.count
    }
    
    /*
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
    let arr = Array(self.songInfoDictionary.keys)
    
    let title = arr[section]
    
    return title
    }
    */
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        var headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: Constants.TABLE_HEADER_HEIGHT))
        headerView.backgroundColor = Color.OffWhite.uiColor
        
        let label = UILabel()
        label.font = UIFont(name: Constants.FONT_PROXIMA_NOVA_REGULAR, size: Constants.FONT_SIZE_INFO_HEADER)
        
        let arr = Array(self.songInfoDictionary.keys)
        
        let title = arr[section]
        
        label.text = title
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
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.SONG_INFO_CELL_IDENTIFIER) as! SongInfoCell
        
        let arr = Array(self.songInfoDictionary.keys)
        let key = arr[indexPath.section]
        
        var votes: [Vote] = self.songInfoDictionary[key]!
        
        let vote = votes[indexPath.row] as Vote
        
        cell.vote = vote
        
        return cell
    }

    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        /*if self.tagCollections != nil
        {
        return self.tagCollections!.getSectionCount()
        }
        */
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        /* if self.tagCollections != nil
        {
        let tagSection = TagCollections.TagSection(rawValue: section)
        
        return self.tagCollections!.getRowCountForTagSection(tagSection!)
        }*/
        
        return self.song!.tags.count
    }
    
    /*
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
    let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: Constants.FILTER_HEADER_IDENTIFIER, forIndexPath: indexPath) as! UICollectionReusableView
    //headerView.frame = CGRect(x: Constants.SIDE_PADDING, y: (CGFloat(indexPath.section) * Constants.FILTER_HEADER_HEIGHT), width: collectionView.width - (Constants.SIDE_PADDING * 2), height: Constants.FILTER_HEADER_HEIGHT)
    
    let tagSection = TagCollections.TagSection(rawValue: indexPath.section)
    
    let headerText = UILabel(frame: CGRect(x: Constants.SIDE_PADDING, y: 0, width: headerView.width - (Constants.SIDE_PADDING * 2), height: headerView.height))
    headerText.font = UIFont(name: Constants.FONT_PROXIMA_NOVA_SEMIBOLD, size: Constants.FONT_SIZE_TAG_HEADER)
    headerText.text = tagSection?.stringValue
    
    headerText.textColor = UIColor.blackColor()
    headerView.addSubview(headerText)
    //headerText.sizeToFit()
    //headerText.centerVerticallyInSuperView()
    //headerText.left = Constants.SIDE_PADDING
    //headerText.left = Constants.SIDE_PADDING
    
    return headerView
    }*/
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.TAG_CELL_IDENTIFIER, forIndexPath: indexPath) as! TagCollectionCell
        
        let tagString = self.song!.tags[indexPath.row]
        
        cell.tagText.text = tagString
        // cell.tagView.tagString = tagString
        
        /*  if self.tagCollections != nil
        {
        let tagSection = TagCollections.TagSection(rawValue: indexPath.section)
        
        let tagInfo = self.tagCollections?.getTagInfoForTagSectionAtRowIndex(tagSection!, index: indexPath.row)
        
        cell.tagInfo = tagInfo
        }*/
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let tagString = self.song!.tags[indexPath.row]
        
        let size = CGSize(width: self.view.width, height: Constants.TAG_CELL_HEIGHT)
        
        let rowSize = Utils.getCellHeightForFont(UIFont(name: Constants.FONT_PROXIMA_NOVA_REGULAR, size: Constants.FONT_SIZE_BIO_CELL)!, text: tagString, bounds: size)
        
        return CGSize(width: (rowSize.width + Constants.TAG_CELL_HEIGHT), height: Constants.TAG_CELL_HEIGHT)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: SegmentView Delegate Methods
    func segmentViewDidSelectViewIndex(segmentView: SegmentView, index: Int)
    {
        switch index
        {
        case 0:
            
            self.songLikesTableView.hidden = true
            self.songInfoView.hidden = false
            
            break
            
        case 1:
            
            self.songLikesTableView.hidden = false
            self.songInfoView.hidden = true
            
            break
            
        default:
            
            break
        }
        
    }
    
	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject?)
	{
		super.apiManagerDidReturnData(apiManager, data: data)
		
        switch apiManager.apiRequest!.requestType
        {
        case .SongDetails:
            var dataDict:NSDictionary = data as! NSDictionary
            self.song = Song(dict: dataDict)
            
            self.songInfoView.song = self.song
            
            self.tagCollectionView.reloadData()
            
            let apiRequest = APIRequest(requestType: APIRequest.RequestType.SongVotes, requestParameters: [APIRequestParameter(key: "", value: "\(self.song!.songID)"), APIRequestParameter(key: "", value: "votes")])
            
            APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, postData: nil)
            
            break
            
        case .SongVotes:
            var dataArray: NSArray = data as! NSArray
            
            var userVotes = [Vote]()
            var producerVotes = [Vote]()
            
            for eachVote in dataArray
            {
                var vote = Vote(dict:eachVote as! NSDictionary)
                if vote.user?.isProducer == true
                {
                    producerVotes.append(vote)
                }
                else
                {
                    userVotes.append(vote)
                }
            }
            
            if producerVotes.count > 0
            {
                self.songInfoDictionary[Constants.KEY_INDUSTRY_VOTERS] = producerVotes
            }
            
            if userVotes.count > 0
            {
                self.songInfoDictionary[Constants.KEY_USER_VOTERS] = userVotes
            }
            
            self.songLikesTableView.reloadData()
            break
            
        default:
            
            break
            
        }
		
		//self.setupGraphDisplay()
	}

}
