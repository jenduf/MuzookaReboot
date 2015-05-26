//
//  SongCell.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/4/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell
{
	@IBOutlet var songName: UILabel!
	@IBOutlet var bandName: UILabel!
	@IBOutlet var rank: UILabel!
	@IBOutlet var songArtwork: UIImageView!
	@IBOutlet var voteButton: UIButton!
	@IBOutlet var menuButton: UIButton!
	
	var song: Song?
	{
		didSet
		{
			self.songName.text = song!.name
			self.bandName.text = song!.band.name
			//self.rank.text = "\(song!.position)"
			
			if song?.band.following == true
			{
				self.voteButton.selected = true
			}
			
			let request = NSURLRequest(URL: NSURL(string: song!.artwork)!)
			NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
				{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
					if data != nil
					{
						let image = UIImage(data: data)
						self.songArtwork.image = image
					}
				}
		}
		
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	override func prepareForReuse()
	{
		super.prepareForReuse()
		
		self.songName.text = ""
		self.bandName.text = ""
		self.rank.text = ""
		
		self.songArtwork.image = nil
	}

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	

}
