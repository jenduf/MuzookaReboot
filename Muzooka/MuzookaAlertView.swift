//
//  MuzookaAlertView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/13/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

protocol MuzookaAlertDelegate
{
	func alertViewDidDismissAtIndex(index: Int)
}

class MuzookaAlertView: UIView
{
	var alertDelegate: MuzookaAlertDelegate?
	
	@IBAction func buttonSelected(sender: UIButton)
	{
		let index = sender.tag
		
		self.alertDelegate!.alertViewDidDismissAtIndex(index)
	}

	
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect)
	{
		let context = UIGraphicsGetCurrentContext()
		let path = UIBezierPath(roundedRect: rect, cornerRadius: Constants.BUTTON_CORNER_RADIUS)
		
		CGContextSaveGState(context)
		CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
		CGContextAddPath(context, path.CGPath)
		CGContextFillPath(context)
		CGContextRestoreGState(context)
	}
	

}
