//
//  LeftNavView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/6/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class LeftNavView: NavContentView
{
	
	@IBOutlet var guestView: UIView!
	@IBOutlet var bannerView: BannerView!
    @IBOutlet var indicatorView: IndicatorView!
	
	func viewWillDisplay()
	{
		if User.currentUser != nil
		{
			self.guestView.hidden = true
			self.bannerView.hidden = false
			
			self.bannerView.user = User.currentUser
		}
		else
		{
			self.guestView.hidden = false
			self.bannerView.hidden = true
		}
		
		self.layer.shadowOffset = CGSize(width: 1, height: 1)
		self.layer.shadowRadius = 2.0
		self.layer.shadowColor = UIColor.blackColor().CGColor
		self.layer.shadowOpacity = 0.5
        
        self.indicatorView!.percent = 1.0
	}
    
    func setSelectedMenuItemWithCallback(yPosition: CGFloat, callback: ()->())
    {
        UIView.animateWithDuration(Constants.SHORT_ANIMATION_DURATION, animations:
        { () -> Void in
            self.indicatorView.transform = CGAffineTransformMakeTranslation(0, yPosition)
        })
        { (Bool) -> Void in
            callback()
        }
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
