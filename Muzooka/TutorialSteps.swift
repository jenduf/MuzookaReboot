
//
//  FirstSteps.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/13/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

enum TutorialSteps: Int
{
	case One = 0, Two = 1, Three = 2, Four = 3
	
	var stepText: String
	{
		switch self
		{
			case .One:
				return "Unlimited, free access \nto the newest and \nhottest music"
			
			case .Two:
				return "Listen to 10 second \nsong highlights - it's like \nspeed dating for music"
			
			case .Three:
				return "Support your favorite \nbands and help them \nmake real industry \nconnections"
			
			case .Four:
				return "The best music you've \nnever heard"
		}
	}
	
	static let steps: [TutorialSteps] =
	[
		.One, .Two, .Three, .Four
	]
	
	
}