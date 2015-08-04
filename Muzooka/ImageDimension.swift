//
//  ImageDimensions.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/1/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public enum ImageDimension: String
{
	case ExtraSmall = "xs", Small = "s", Medium = "m", Large = "l"
	
	static let dimensions: [ImageDimension] =
	[
		.ExtraSmall, .Small, .Medium, .Large
	]
    
    public func getImageDimensionAtURL(url: String) -> String
    {
        let imageString = url.stringByReplacingOccurrencesOfString("{%s}", withString: self.rawValue, options: NSStringCompareOptions.allZeros, range: nil)
        
        return imageString
    }
	
}