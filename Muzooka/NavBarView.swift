//
//  NavBarView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/4/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class NavBarView: UIView
{
	@IBOutlet var leftButton: NavButton!
	@IBOutlet var rightButton: NavButton!
	@IBOutlet var title: UILabel!
	
	func updateForScreen(screen: NavScreen)
	{
		self.title.text = screen.titleText
		
		switch screen
		{
			case .Playlists:
				self.leftButton.updateForNavButtonType(.Hamburger)
				self.rightButton.updateForNavButtonType(.Add)
				break
			
			case .Artist:
				self.leftButton.updateForNavButtonType(.BackArrow)
				self.rightButton.updateForNavButtonType(.Funnel)
				break
			
			case .EditProfile:
				self.leftButton.updateForNavButtonType(.BackArrow)
				self.rightButton.updateForNavButtonType(.Save)
				break
			
			case .Artist, .Profile:
				self.leftButton.updateForNavButtonType(.Hamburger)
				self.rightButton.updateForNavButtonType(.Share)
				break
			
			case .SearchDetail:
				self.leftButton.updateForNavButtonType(.BackArrow)
				self.rightButton.updateForNavButtonType(.None)
				break
			
			case .Search:
				self.leftButton.updateForNavButtonType(.Hamburger)
				self.rightButton.updateForNavButtonType(.None)
				break
			
			default:
				self.leftButton.updateForNavButtonType(.Hamburger)
				self.rightButton.updateForNavButtonType(.Funnel)
				break
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
