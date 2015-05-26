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
	case Hamburger = 0, Funnel, BackArrow, Add
	
	public static let imageNames = ["nav_icon", "filter_icon", "back_arrow", "playlist_add_icon"]
	
	public var imageForType: String
	{
		return NavButtonType.imageNames[self.rawValue]
	}
}