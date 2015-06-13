//
//  ProducerCell.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class ProducerCell: UICollectionViewCell
{
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var userNameLabel: UILabel!
	@IBOutlet var producerImage: UIImageView!
	
	var producer: Producer?
	{
		didSet
		{
			self.nameLabel.text = producer?.name
			self.userNameLabel.text = producer?.userName
			
			/*
			let request = NSURLRequest(URL: NSURL(string: producer!.avatar)!)
			NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
				{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
					let image = UIImage(data: data)
					self.producerImage.image = image
			}
			*/
			
			self.producerImage.loadFromURL(NSURL(string: producer!.avatar)!)
		}
	}
    
}
