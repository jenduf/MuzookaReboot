//
//  DiscoverButton.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/13/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class DiscoverButton: UIButton
{

	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect)
	{
		let context = UIGraphicsGetCurrentContext()
		
		CGContextSaveGState(context)
		CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().colorWithAlphaComponent(0.25).CGColor)
		CGContextSetLineWidth(context, Constants.DISCOVER_STROKE)
		CGContextStrokeEllipseInRect(context, rect.rectByInsetting(dx: 3.0, dy: 3.0))
		CGContextRestoreGState(context)
	}

}
