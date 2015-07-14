//
//  NavButtonType.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/15/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public enum NavButtonType: Int
{
	case None = 0, Hamburger, Funnel, BackArrow, Add, Save, Share, ClearAll
	
	public static let imageNames = ["", "nav_icon", "filter_icon", "back_arrow", "playlist_add_icon", "", "share_icon", ""]
	
	public static let buttonText = ["", "", "", "", "", "Save", "", "Clear All"]
	
	public var imageForType: String
	{
		return NavButtonType.imageNames[self.rawValue]
	}
	
	public var textForType: String
	{
		return NavButtonType.buttonText[self.rawValue]
	}
	
	public var colorForType: UIColor
	{
		switch self
		{
			case .Save, .ClearAll:
				return Color.SearchTint.uiColor
				
			default:
				return UIColor.whiteColor()
		}
	}
}