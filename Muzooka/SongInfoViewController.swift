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
			self.loadData()
		}
	}
	
	var song: Song?
	{
		didSet
		{
			self.artistName.text = song?.band.name
			self.songName.text = song?.name
			
			let request = NSURLRequest(URL: NSURL(string: song!.artwork)!)
			NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
			{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
				let image = UIImage(data: data)
				self.songArtwork.image = image
			}
		}
	}
	
	override func loadData()
	{
		super.loadData()
		
		APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.SongDetails, delegate: self, parameters: nil, appendedString: "\(self.songID!)")
	}

	override func viewDidLoad()
	{
        super.viewDidLoad()

        // Do any additional setup after loading the view.
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject)
	{
		super.apiManagerDidReturnData(apiManager, data: data)
		
		var dataDict:NSDictionary = data as! NSDictionary
		
		self.song = Song(dict: dataDict)
		
		self.graphView.graphPoints = self.song!.hotChartDays
	}

}
