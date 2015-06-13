//
//  IndicatorView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/4/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class IndicatorView: UIView
{
	
	var percent: CGFloat = 0.0
	{
		/*UIView.animateWithDuration(0.1, animations:
		{ () -> Void in
		self.indicatorView.frame.size.width = self.frame.width * percent
		})*/
		
		didSet
		{
			self.setNeedsDisplay()
		}
	}
	
	override func drawRect(rect: CGRect)
	{
		super.drawRect(rect)
		
		let context = UIGraphicsGetCurrentContext()
		
		let percentWidth = rect.size.width * self.percent
		
		let percentRect = CGRect(x: 0, y: 0, width: percentWidth, height: rect.size.height)
		
		//println("width: \(percentWidth)")
		
		CGContextSaveGState(context)
		CGContextSetFillColorWithColor(context, Color.MenuActive.uiColor.CGColor)
		CGContextFillRect(context, percentRect)
		CGContextRestoreGState(context)
	}
}
