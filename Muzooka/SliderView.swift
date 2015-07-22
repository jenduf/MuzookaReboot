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

	@IBOutlet var sliderButton: UIButton!
	
	var percent: CGFloat = 0.0
	{
		didSet
		{
			let percentWidth = self.width * self.percent
			self.sliderButton.center = CGPoint(x: percentWidth, y: self.sliderButton.center.y)
			
			//	self.sliderButton.moveBy(CGPoint(x: percent, y: 0))
			
			self.setNeedsDisplay()
		}
	}
	
	override func layoutSubviews()
	{
		super.layoutSubviews()
		
		if self.sliderButton != nil
		{
			self.sliderButton.layer.backgroundColor = Color.MusicSliderColor.uiColor.CGColor
			self.sliderButton.layer.cornerRadius = self.sliderButton.height / 2
			self.sliderButton.layer.masksToBounds = true
		}
	}
	
	override func drawRect(rect: CGRect)
	{
		super.drawRect(rect)
		
		let context = UIGraphicsGetCurrentContext()
		
		// draw background
		let backgroundRect = CGRect(x: 0, y: (rect.height - Constants.SLIDER_TRACK_HEIGHT) / 2, width: rect.width, height: Constants.SLIDER_TRACK_HEIGHT)
		let backgroundPath = UIBezierPath(roundedRect: backgroundRect, cornerRadius: self.height / 2)
		CGContextSaveGState(context)
		CGContextSetFillColorWithColor(context, UIColor.whiteColor().colorWithAlphaComponent(0.5).CGColor)
		CGContextAddPath(context, backgroundPath.CGPath)
		CGContextDrawPath(context, kCGPathFill)
		CGContextRestoreGState(context)
		
		let percentWidth = rect.size.width * self.percent
		
		let percentRect = CGRect(x: 0, y: (rect.height - Constants.SLIDER_TRACK_HEIGHT) / 2, width: percentWidth, height: Constants.SLIDER_TRACK_HEIGHT)
		
		//println("width: \(percentWidth)")
		let path = UIBezierPath(roundedRect: percentRect, byRoundingCorners: .BottomLeft | .TopLeft, cornerRadii: CGSize(width: self.width / 2, height: self.height / 2))
		CGContextSaveGState(context)
		CGContextSetFillColorWithColor(context, Color.MusicSliderColor.uiColor.CGColor)
		CGContextAddPath(context, path.CGPath)
		CGContextDrawPath(context, kCGPathFill)
		CGContextRestoreGState(context)
	}

}
