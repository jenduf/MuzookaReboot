//
//  NavButton.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/15/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class NavButton: UIButton
{

	func updateForNavButtonType(type: NavButtonType)
	{
		self.tag = type.rawValue
		
		self.setImage(UIImage(named: type.imageForType), forState: UIControlState.Normal)
	}
	
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
