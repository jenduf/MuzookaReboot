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
	
	override func drawRect(rect: CGRect)
	{
		let context = UIGraphicsGetCurrentContext()
		
		CGContextSaveGState(context)
		CGContextSetFillColorWithColor(context, Utils.UIColorFromRGB(Color.MenuActive.hex, alpha: 1.0).CGColor)
		CGContextFillRect(context, rect)
		CGContextRestoreGState(context)
		
		super.drawRect(rect)
	}
}
