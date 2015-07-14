//
//  SearchView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/3/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class SearchView: UIView
{

	override func drawLayer(layer: CALayer!, inContext ctx: CGContext!)
	{
		self.layer.borderColor = Color.SearchBorderColor.uiColor.CGColor
		self.layer.borderWidth = 1
		
		super.drawLayer(layer, inContext: ctx)
	}
	
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect)
	{
		// Drawing code
	}

}
