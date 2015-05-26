
//
//  Settings.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public enum Settings: Int
{
	case QualitySettings = 0, ChangePassword = 1, FindFriends = 2, Feedback = 3, Terms = 4
	
	public static let values = [QualitySettings, ChangePassword, FindFriends, Feedback, Terms]
	
	public static let strings = ["Quality Settings", "Change Password", "Find Friends",  "Send Feedback", "Terms of Service & Privacy Policy"]
	
	public var description: String
	{
		return Settings.strings[self.rawValue]
	}
	
	static func getSettingsValuesForLoginState() -> [Settings]
	{
		if User.currentUser != nil
		{
			return Settings.values
		}
		
		return [Feedback, Terms]
	}
}