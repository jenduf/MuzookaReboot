//
//  Utils.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/4/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

public class Utils
{
	
	class func UIColorFromRGB(colorCode: String, alpha: Float = 1.0) -> UIColor
	{
		var adjustedString: String = colorCode
		
		if colorCode.hasPrefix("#")
		{
			let index = advance(colorCode.startIndex, 1)
			adjustedString = colorCode.substringFromIndex(index)
		}
		
		var scanner = NSScanner(string: adjustedString)
		var color: UInt32 = 0
		scanner.scanHexInt(&color)
		
		let mask = 0x000000FF
		let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
		let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
		let b = CGFloat(Float(Int(color) & mask)/255.0)
		
		return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
	}
}
