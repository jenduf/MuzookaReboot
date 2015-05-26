//
//  BorderedButton.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class BorderedButton: UIButton
{

	var strokeColor: UIColor = UIColor.clearColor()
	{
		didSet
		{
			self.setNeedsDisplay()
		}
	}
	
	override func awakeFromNib()
	{
		super.awakeFromNib()
		
		var color = Color(rawValue:self.tag)
		
		if color!.rawValue > 0
		{
			self.strokeColor = Utils.UIColorFromRGB(color!.hex, alpha: 1.0)
		}
		else
		{
			self.strokeColor = UIColor.clearColor()
			self.layer.cornerRadius = Constants.BUTTON_CORNER_RADIUS
			self.layer.masksToBounds = true
		}
		
	}
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		
		self.strokeColor = UIColor.whiteColor()
	}
	

	required init(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
	}
	
	init(frame: CGRect, text: String, stroke: UIColor, fontSize: CGFloat)
	{
		super.init(frame: frame)
		
		self.titleLabel?.font = UIFont(name: Constants.FONT_PROXIMA_NOVA_SEMIBOLD, size: fontSize)
		
		self.setTitle(text, forState: UIControlState.Normal)
		
		self.strokeColor = stroke
	}
	
	
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect)
	{
		let context = UIGraphicsGetCurrentContext()
		let path = UIBezierPath(roundedRect: rect.rectByInsetting(dx: 2.0, dy: 2.0), cornerRadius: Constants.BUTTON_CORNER_RADIUS)
		
		CGContextSaveGState(context)
		CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor)
		CGContextSetLineWidth(context, 2.0)
		//CGContextAddPath(context, path.CGPath)
		//CGContextClip(context)
		CGContextAddPath(context, path.CGPath)
		CGContextStrokePath(context)
		CGContextRestoreGState(context)
	}

}
