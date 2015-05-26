//
//  LoadingAnimationView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/14/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class LoadingAnimationView: UIView
{
	@IBOutlet var animatingImageView: UIImageView!
	
	
	override func awakeFromNib()
	{
		super.awakeFromNib()
		
		self.setupAnimatingImages()
	}
	
	func setupAnimatingImages()
	{
		// initialize animation image array
		self.animatingImageView.animationImages = [UIImage]()
		
		for var index = 0; index < Constants.TOTAL_ANIMATING_IMAGES; index++
		{
			var frameName = "loading_\(index)"
			//println("image name: \(frameName)")
			self.animatingImageView.animationImages?.append(UIImage(named: frameName)!)
		}
	}
	
	func startAnimating()
	{
		self.animatingImageView.animationDuration = 1.75
		self.animatingImageView.startAnimating()
		
		UIView.animateWithDuration(0.15, animations:
		{ () -> Void in
			self.alpha = 1.0
		})
	}
	
	func stopAnimating()
	{
		self.animatingImageView.stopAnimating()
		
		UIView.animateWithDuration(0.15, animations:
		{ () -> Void in
			self.alpha = 0.0
		})
	}

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
