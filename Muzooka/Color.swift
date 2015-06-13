//
//  Colors.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/7/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

enum Color: Int
{
	case None = 0, White = 1, MenuActive = 2, MenuInactive = 3, TextDark = 4, ButtonGreyBackground = 5, SearchTextColor = 6, SearchHeaderTextColor = 7, OffWhite = 8, SeparatorColor = 9
	
	static var hexValues = ["", "FFFFFF", "34b5e5", "707676", "4a4d4d", "464C4C", "8E8E93", "9B9B9B", "F8F8F8", "979797"]
	
	var uiColor: UIColor
	{
		return Utils.UIColorFromRGB(Color.hexValues[self.rawValue], alpha: 1.0)
	}
}
