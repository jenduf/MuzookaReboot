
//
//  UIImageView+Download.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/9/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

extension UIImageView
{
	typealias ImageCallback = (image: UIImage) -> Void
	
	func loadFromURL(url: NSURL)
	{
		let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
		
		dispatch_async(queue,
		{
			let imageData = NSData(contentsOfURL: url)
			
			if imageData != nil
			{
				dispatch_async(dispatch_get_main_queue(),
				{ () -> Void in
					let newImage = UIImage(data: imageData!)
					self.image = newImage
				})
			}
		})
	}
}