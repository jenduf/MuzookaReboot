//
//  ShareProvider.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/17/15.
//  Copyright (c) 2015 com.muzooka. All rights reserved.
//

import UIKit

class ShareProvider: UIActivityItemProvider, UIActivityItemSource
{
	
	var shareableObject: Shareable?
	/*
	func initWithShareable(shareable: Shareable)
	{
		self.shareableObject = shareable
		
		self.ini
	}
	
	override init(placeholderItem: AnyObject)
	{
		super.init(placeholderItem: placeholderItem)
	}
	
	*/
	
	override func activityViewControllerPlaceholderItem(activityViewController: UIActivityViewController) -> AnyObject
	{
		return ""
	}
	
	override func activityViewController(activityViewController: UIActivityViewController, itemForActivityType activityType: String) -> AnyObject?
	{
		switch activityType
		{
			case UIActivityTypeMail:
				return self.getEmailShareMessage()
			
			case UIActivityTypeMessage:
				return self.getEmailShareMessage()
			
			case UIActivityTypePostToFacebook:
				return self.getFacebookShareMessage()
			
			case UIActivityTypePostToTwitter:
				return self.getTwitterShareMessage()
			
			default:
				return ""
		}
	}
	
	override func activityViewController(activityViewController: UIActivityViewController, subjectForActivityType activityType: String?) -> String
	{
		switch self.shareableObject!.shareableType()
		{
			case .Song:
				return "Check out this song \(self.shareableObject!.getShareDetails()) on Muzooka"
				
			case .Band:
				return "Check out this band \(self.shareableObject!.getShareDetails()) on Muzooka"
			
			case .Playlist:
				return "Check out this playlist \(self.shareableObject!.getShareDetails()) on Muzooka"
				
			case .User:
				return "Take a look at this profile \(self.shareableObject!.getShareDetails()) on Muzooka"
			
			default:
				return ""
		}
	}
	
	
	// MARK: Helper Methods
	func getFacebookShareMessage() -> String
	{
		var shareMessage = ""
		
		switch self.shareableObject!.shareableType()
		{
			case .Song:
				shareMessage = "Check out this #song \(self.shareableObject!.getShareDetails()) on Muzooka #MusicFirst"
				break
			
			case .Band:
				shareMessage = "Check out this #band \(self.shareableObject!.getShareDetails()) on Muzooka #MusicFirst"
				break
			
			case .Playlist:
				shareMessage = "Check out this #playlist \(self.shareableObject!.getShareDetails()) on Muzooka #MusicFirst"
				break
			
			case .User:
				shareMessage = "Check out this #profile \(self.shareableObject!.getShareDetails()) on Muzooka #MusicFirst"
				break
			
			default:
				break
		}
		
		return shareMessage
	}
	
	func getTwitterShareMessage() -> String
	{
		var shareMessage = ""
		
		switch self.shareableObject!.shareableType()
		{
			case .Song:
				shareMessage = "Check out this #song \(self.shareableObject!.getShareDetails()) on @muzooka #MusicFirst"
				break
				
			case .Band:
				shareMessage = "Check out this #band \(self.shareableObject!.getShareDetails()) on @muzooka #MusicFirst"
				break
				
			case .Playlist:
				shareMessage = "Check out this #playlist \(self.shareableObject!.getShareDetails()) on @muzooka #MusicFirst"
				break
				
			case .User:
				shareMessage = "Check out this #profile \(self.shareableObject!.getShareDetails()) on @muzooka #MusicFirst"
				break
			
			default:
				break
		}
		
		return shareMessage
	}
	
	func getEmailShareMessage() -> String
	{
		var shareMessage = ""
		
		switch self.shareableObject!.shareableType()
		{
			case .Song:
				shareMessage = "Check out this song \(self.shareableObject!.getShareDetails()) on Muzooka"
				break
				
			case .Band:
				shareMessage = "Check out this band \(self.shareableObject!.getShareDetails()) on Muzooka"
				break
				
			case .Playlist:
				shareMessage = "Check out this playlist \(self.shareableObject!.getShareDetails()) on Muzooka"
				break
				
			case .User:
				shareMessage = "Check out this profile of \(self.shareableObject!.getShareDetails()) . Found on Muzooka"
				break
			
			default:
				break
		}
		
		return shareMessage
	}
	
}
