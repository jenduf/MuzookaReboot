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
	var navButtonType: NavButtonType?
	
	func updateForNavButtonType(type: NavButtonType)
	{
		self.navButtonType = type
		
		self.tag = type.rawValue
		
		self.setImage(UIImage(named: type.imageForType), forState: UIControlState.Normal)
		
		self.setTitle(type.textForType, forState: UIControlState.Normal)
	}
	
	override func drawLayer(layer: CALayer!, inContext ctx: CGContext!)
	{
		if self.navButtonType == NavButtonType.Save
		{
			layer.borderColor = Color.MenuActive.uiColor.CGColor
			layer.borderWidth = 2.0
		}
		else
		{
			layer.borderWidth = 0.0
		}
		
		super.drawLayer(layer, inContext: ctx)
	}
	
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect)
	{
        // Drawing code
	}
	

}
