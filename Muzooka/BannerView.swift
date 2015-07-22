//
//  BannerView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/28/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class BannerView: UIView
{
	@IBOutlet var avatarView: AvatarView!
	@IBOutlet var backgroundImageView: UIImageView!
	
	var user: User?
	{
		didSet
		{
			if self.avatarView != nil
			{
				self.avatarView.user = user
			}
			
			self.backgroundImageView.loadFromURL(NSURL(string: user!.avatarURL!)!)
			
			//.image = //User.currentUser.image
		}
	}
	
	var artURL: String?
	{
		didSet
		{
			if self.backgroundImageView != nil
			{
				self.backgroundImageView.loadFromURLWithCallback(NSURL(string: artURL!)!, callback:
				{ (downloadedImage) -> () in
					self.backgroundImageView.blurImage(downloadedImage)
				})
			}
		}
	}
	
	var blurView: UIVisualEffectView?
	
	override func layoutSubviews()
	{
		if self.blurView == nil
		{
			// blur background image
			var lightBlur = UIBlurEffect(style: .Dark)
			
			self.blurView = UIVisualEffectView(effect: lightBlur)
			self.blurView!.frame = self.bounds
			
			if self.avatarView != nil
			{
				self.insertSubview(self.blurView!, belowSubview: self.avatarView)
			}
			else
			{
				self.addSubview(self.blurView!)
			}
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
