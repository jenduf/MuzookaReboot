//
//  DiscoverActionView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/13/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class DiscoverActionView: UIView
{
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var artistLabel: UILabel!
	@IBOutlet var passButton: DiscoverButton!
	@IBOutlet var addButton: DiscoverButton!
	@IBOutlet var indicatorView: IndicatorView!
	
	var song: Song?
	{
		didSet
		{
			self.titleLabel.text = song!.name
			self.artistLabel.text = song!.band.name
		}
	}
	
	func toggleButtonsForLocation(location: CGFloat)
	{
		let buttonDiscardRight = CGRectGetMaxX(self.passButton.frame)
		
		if location <= buttonDiscardRight
		{
			UIView.animateWithDuration(Constants.SHORT_ANIMATION_DURATION, delay: 0.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations:
				{ () -> Void in
					self.passButton.transform = CGAffineTransformMakeScale(1.2, 1.2)
				},
				completion:
				{ (Bool) -> Void in
					
			})
		}
		else
		{
			UIView.animateWithDuration(Constants.SHORT_ANIMATION_DURATION, delay: 0.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations:
				{ () -> Void in
					self.passButton.transform = CGAffineTransformIdentity
				},
				completion:
				{ (Bool) -> Void in
					
			})
		}
		
		
		let buttonFaveLeft = self.addButton.frame.origin.x
		
		if location >= buttonFaveLeft
		{
			//self.addButton.isActive = true
			
			UIView.animateWithDuration(Constants.SHORT_ANIMATION_DURATION, delay: 0.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations:
				{ () -> Void in
					self.addButton.transform = CGAffineTransformMakeScale(1.2, 1.2)
				}, completion:
				{ (Bool) -> Void in
					
			})
		}
		else
		{
			//self.addButton.isActive = false
			
			UIView.animateWithDuration(Constants.SHORT_ANIMATION_DURATION, delay: 0.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations:
				{ () -> Void in
					self.addButton.transform = CGAffineTransformIdentity
				},
				completion:
				{ (Bool) -> Void in
					
			})
		}

	}
	
	func reset()
	{
		self.addButton.transform = CGAffineTransformIdentity
		//self.addButton.isActive = false
		self.passButton.transform = CGAffineTransformIdentity
	}
	
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
