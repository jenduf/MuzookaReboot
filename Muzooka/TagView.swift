//
//  TagView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/2/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class TagView: UIView
{
	
	@IBOutlet var tagText: UILabel!
	
	var tagString: String?
	{
		didSet
		{
			self.tagText.text = tagString
			self.tagText.sizeToFit()
			self.setNeedsDisplay()
		}
	}

	override func drawLayer(layer: CALayer!, inContext ctx: CGContext!)
	{
		self.tagText.layer.borderColor = Color.TagBorderColor.uiColor.CGColor
		self.tagText.layer.borderWidth = 3
		self.tagText.layer.frame = CGRect(origin: CGPoint(x: self.tagText.left - Constants.SIDE_PADDING, y: self.tagText.top - Constants.PADDING), size: CGSize(width: self.tagText.width + (Constants.SIDE_PADDING * 2), height: self.tagText.height + Constants.SIDE_PADDING))
		
		self.tagText.layer.cornerRadius = (self.tagText.height / 2)
		
		super.drawLayer(layer, inContext: ctx)
	}
	
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect)
	{
		// Drawing code
	}

}
