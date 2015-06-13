//
//  PartnerCell.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class PartnerCell: UITableViewCell
{
	@IBOutlet var bannerImage: UIImageView!
	@IBOutlet var bannerText: UILabel!
	
	var partner: Partner?
	{
		didSet
		{
			self.bannerText.text = partner!.descriptionShort
			
		/*	let request = NSURLRequest(URL: NSURL(string: partner!.banner)!)
			NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
				{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
					let image = UIImage(data: data)
					self.bannerImage.image = image
			}*/
			
			self.bannerImage.loadFromURL(NSURL(string: partner!.banner)!)
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
	
	override func prepareForReuse()
	{
		super.prepareForReuse()
		
		self.bannerText.text = ""
		
		self.bannerImage.image = nil
	}

}
