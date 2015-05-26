//
//  ScoreView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/6/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class ScoreView: UIView
{
	let countLabel: UILabel =
	{
		let label = UILabel()
		label.font = UIFont(name: Constants.FONT_PROXIMA_NOVA_SEMIBOLD, size: Constants.FONT_SIZE_STEP)
		label.textAlignment = .Center
		label.textColor = UIColor.whiteColor()
		
		return label
	}()
	
	@IBInspectable
	var count: String?
	{
		didSet
		{
			self.countLabel.text = count
		}
	}
	
	
	var fillColor: UIColor?
	{
		didSet
		{
			self.setNeedsDisplay()
		}
	}

	
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect)
	{
		let context = UIGraphicsGetCurrentContext()
		
		CGContextSaveGState(context)
		CGContextSetFillColorWithColor(context, self.fillColor?.CGColor)
		CGContextFillEllipseInRect(context, rect)
		CGContextRestoreGState(context)
	}

}
