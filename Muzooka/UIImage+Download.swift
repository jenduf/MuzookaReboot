//
//  UIImage+Download.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/9/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

extension UIImage
{
	typealias ImageCallback = (image: UIImage) -> Void
	
	func loadFromURL(url: NSURL, callback: (image: UIImage)->())
	{
		let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
		
		dispatch_async(queue,
		{
			let imageData = NSData(contentsOfURL: url)
			
			dispatch_async(dispatch_get_main_queue(),
			{ () -> Void in
				let image = UIImage(data: imageData!)
				callback(image: image!)
			})
		})
	}
}