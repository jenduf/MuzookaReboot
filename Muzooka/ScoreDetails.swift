
//
//  ScoreDetails.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/6/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public struct ScoreDetails
{
	var score: Int = 0
	var colorCode: String
	
	init(score: Int, colorCode: String)
	{
		self.score = score
		self.colorCode = colorCode
	}
	
	init(dict: NSDictionary)
	{
		self.score = dict["score"] as! Int
		self.colorCode = dict["code"] as! String
	}
}