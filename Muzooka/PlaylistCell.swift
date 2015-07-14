//
//  PlaylistCell.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/26/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class PlaylistCell: UICollectionViewCell
{
	@IBOutlet var artImageView: UIImageView!
	
	@IBOutlet var songCount: UILabel!
	
	@IBOutlet var nameLabel: UILabel!
	
	@IBOutlet var subscribers: UILabel!
	
	var playlist: Playlist?
	{
		didSet
		{
			self.songCount.text = "\(playlist!.songCount)"
			
			self.nameLabel.text = "\(playlist!.name)"
			
			self.subscribers.text = "\(playlist!.subscribers) subscribers"
			
			/*
			let request = NSURLRequest(URL: NSURL(string: playlist!.artwork)!)
			NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
			{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
				let image = UIImage(data: data)
				self.artImageView.image = image
			}
			
			*/
			
			if let artURL = playlist?.artwork
			{
				self.artImageView.loadFromURL(NSURL(string: artURL)!)
			}
			else
			{
				self.artImageView.image = UIImage(named: Constants.IMAGE_DEFAULT_PLAYLIST)
			}
		}
		
	}
	
	override func prepareForReuse()
	{
		super.prepareForReuse()
		
		if self.songCount != nil
		{
			self.songCount.text = ""
		}
		
		if self.nameLabel != nil
		{
			self.nameLabel.text = ""
		}
		
		if self.subscribers != nil
		{
			self.subscribers.text = ""
		}
		
		if self.artImageView != nil
		{
			self.artImageView.image = nil
		}
	}
	
}
