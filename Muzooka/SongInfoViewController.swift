//
//  SongInfoViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/15/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class SongInfoViewController: MuzookaViewController
{
	@IBOutlet var artistName: UILabel!
	@IBOutlet var songName: UILabel!
	@IBOutlet var songArtwork: UIImageView!
	@IBOutlet var segmentView: SegmentView!
	@IBOutlet var likesView: UIView!
	@IBOutlet var graphView: GraphView!
	
	var songID: String?
	{
		didSet
		{
			//self.loadData()
		}
	}
	
	var song: Song?
	{
		didSet
		{
			self.artistName.text = song?.band.name
			self.songName.text = song?.name
			
			/*
			let request = NSURLRequest(URL: NSURL(string: song!.artwork!)!)
			NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
			{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
				let image = UIImage(data: data)
				self.songArtwork.image = image
			}*/
			
			self.songArtwork.loadFromURL(NSURL(string: song!.artwork!)!)
		}
	}

	override func viewDidLoad()
	{
        super.viewDidLoad()

        // Do any additional setup after loading the view.
	}
	
	override func loadData()
	{
		super.loadData()
		
		let apiRequest = APIRequest(requestType: APIRequest.RequestType.SongDetails, requestParameters: [APIRequestParameter(key: "", value: "\(self.songID!)")])
		
		APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, postData: nil) //appendedString: "\(self.songID!)")
	}
	
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject?)
	{
		super.apiManagerDidReturnData(apiManager, data: data)
		
		var dataDict:NSDictionary = data as! NSDictionary
		
		self.song = Song(dict: dataDict)
		
		self.setupGraphDisplay()
	}

}
