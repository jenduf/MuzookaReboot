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
	@IBOutlet var avatarView: AvatarView!
	
	func viewWillDisplay()
	{
		if User.currentUser != nil
		{
			self.guestView.hidden = true
			self.avatarView.hidden = false
			
			self.avatarView.user = User.currentUser
		}
		else
		{
			self.guestView.hidden = false
			self.avatarView.hidden = true
		}
		
		self.layer.shadowOffset = CGSize(width: 1, height: 1)
		self.layer.shadowRadius = 2.0
		self.layer.shadowColor = UIColor.blackColor().CGColor
		self.layer.shadowOpacity = 0.5
	}

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
