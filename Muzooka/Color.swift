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
	case None = 0, White = 1, MenuActive = 2, MenuInactive = 3, TextDark = 4, ButtonGreyBackground = 5, SearchTextColor = 6, SearchHeaderTextColor = 7, OffWhite = 8, SeparatorColor = 9, MusicSliderColor = 10, SearchTint = 11, SearchBackgroundColor = 12, CellHighlight, NavBackgroundColor, TagBorderColor, SearchBorderColor, TrendingUpGreen, TrendingDownRed, GraphLine, GraphBorder, GraphCurveBorder
	
	static var hexValues =
        // White
    ["", "FFFFFF", "34b5e5", "707676", "4a4d4d", "464C4C",
        // SearchTextColor
        "8E8E93", "9B9B9B", "F8F8F8", "979797", "00B9FF", "00ACED",
        // SearchBackgroundColor
        "171717", "F3F3F3", "303232", "E2E2E2", "C1C1C1",
        // TrendingUpGreen
        "26AF91", "E13331", "DEDEDE", "A2A2A2", "F57021"]
	
	var uiColor: UIColor
	{
		return Utils.UIColorFromRGB(Color.hexValues[self.rawValue], alpha: (self == .None ? 0.0 : 1.0))
	}
}
