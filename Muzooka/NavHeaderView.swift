//
//  NavHeaderView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/21/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class NavHeaderView: UIView
{
	@IBOutlet var navBarView: NavBarView!
	@IBOutlet var segmentView: SegmentView!
	
	func updateForScreen(screen: NavScreen)
	{
		self.navBarView.updateForScreen(screen)
		
		if screen.subHeadings.count > 0
		{
			self.segmentView.updateSegments(screen.subHeadings)
		}
		
		/*
		if screen.subHeadings.count == 0
		{
			UIView.animateWithDuration(0.2, animations:
			{ () -> Void in
				self.frame.size.height = self.navBarView.frame.maxY
			})
		}
		else
		{
			UIView.animateWithDuration(0.2, animations:
			{ () -> Void in
				self.frame.size.height = self.segmentView.frame.maxY
			},
			completion:
			{ (Bool) -> Void in
				
				self.segmentView.updateSegments(screen.subHeadings, width: self.frame.width)
			})
		}*/
	}
	
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
