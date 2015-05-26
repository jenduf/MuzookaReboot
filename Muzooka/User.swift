
//
//  User.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/6/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public class User
{
	public let userID: Int
	public let name: String
	public let userName: String
	public let scoreDetails: ScoreDetails
	public let email: String
	public let avatarURL: String?
	public var image: UIImage?
	
	static var currentUser: User!
	
	public init(dict: NSDictionary)
	{
		self.userID = dict["id"] as! Int
		self.name = dict["name"] as! String
		self.userName = dict["username"] as! String
		self.scoreDetails = ScoreDetails(dict: dict["scoredetails"] as! NSDictionary)
		self.email = dict["email"] as! String
		self.avatarURL = dict["avatar"] as? String
		
		if self.avatarURL != nil
		{
			self.getImage()
		}
		
	}
	
	func getImage()
	{
		let request = NSURLRequest(URL: NSURL(string: self.avatarURL!)!)
			NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
			{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
					let downloadedImage = UIImage(data: data)
					self.image = downloadedImage
			}
	}
	
}