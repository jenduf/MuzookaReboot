//
//  PlaylistTableCell.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/27/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class PlaylistTableCell: UITableViewCell
{
	@IBOutlet var artwork: UIImageView!
	@IBOutlet var title: UILabel!
	@IBOutlet var songCount: UILabel!
	
	var playlist: Playlist?
	{
		didSet
		{
			self.title.text = playlist!.name
			self.songCount.text = "\(playlist!.songCount) Songs"
			
			/*
			let request = NSURLRequest(URL: NSURL(string: playlist!.artwork)!)
			NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
			{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
				let image = UIImage(data: data)
				self.artwork.image = image
			}
			*/
			
			self.artwork.loadFromURL(NSURL(string: playlist!.artwork)!)
		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
