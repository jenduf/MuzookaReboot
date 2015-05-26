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
	case None = 0, OffWhite = 1, MenuActive = 2, MenuInactive = 3
	
	var hex: String
	{
		switch self
		{
			case .None:
				return ""
			
			case .OffWhite:
				return "FFFFFF"
			
			case .MenuActive:
				return "34b5e5"
			
			case .MenuInactive:
				return "707676"
		
			default:
		
				break
		}
		
	}
}
