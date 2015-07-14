
//
//  TagInfo.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/2/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation


public struct TagInfo
{
	public var name: String
	public var songCount: Int = 0
	
	init(dict: NSDictionary)
	{
		self.name = dict["name"] as! String
		self.songCount = dict["songs_count"] as! Int
	}
	
	func getWidthOfString() -> CGFloat
	{
		//let attString = NSAttributedString(string: self.name)
		//let rect = attString.boundingRectWithSize(CGSize(width: CGFloat.max, height: 40), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
		
		//let size = attString.size()
		
		let nsName = self.name as NSString
		
		var attributes = [ NSFontAttributeName : UIFont(name: Constants.FONT_PROXIMA_NOVA_REGULAR, size: Constants.FONT_SIZE_TAG_TEXT)!]
		
		let attSize = nsName.sizeWithAttributes(attributes)
		
		//println("RECT: \(rect) SIZE: \(size) ATTSIZE: \(attSize)")
		
		return attSize.width
	}
}