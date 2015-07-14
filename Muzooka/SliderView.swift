//
//  SliderView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/8/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class SliderView: UIView
{

	var percent: CGFloat = 0.0
	{
		didSet
		{
			self.setNeedsDisplay()
		}
	}
	
	override func drawRect(rect: CGRect)
	{
		super.drawRect(rect)
		
		let context = UIGraphicsGetCurrentContext()
		
		// draw background
		let backgroundPath = UIBezierPath(roundedRect: rect, cornerRadius: self.height / 2)
		CGContextSaveGState(context)
		CGContextSetFillColorWithColor(context, UIColor.whiteColor().colorWithAlphaComponent(0.5).CGColor)
		CGContextAddPath(context, backgroundPath.CGPath)
		CGContextDrawPath(context, kCGPathFill)
		CGContextRestoreGState(context)
		
		let percentWidth = rect.size.width * self.percent
		
		let percentRect = CGRect(x: 0, y: 0, width: percentWidth, height: rect.size.height)
		
		//println("width: \(percentWidth)")
		let path = UIBezierPath(roundedRect: percentRect, byRoundingCorners: .BottomLeft | .TopLeft, cornerRadii: CGSize(width: self.width / 2, height: self.height / 2))
		CGContextSaveGState(context)
		CGContextSetFillColorWithColor(context, Color.MenuActive.uiColor.CGColor)
		CGContextAddPath(context, path.CGPath)
		CGContextDrawPath(context, kCGPathFill)
		CGContextRestoreGState(context)
	}

}
