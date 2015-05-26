
//
//  Producer.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public class Producer
{
	public let producerID: Int
	public let name: String
	public let userName: String
	public let avatar: String
	
	public init(dict: NSDictionary)
	{
		self.producerID = dict["id"] as! Int
		self.name = dict["name"] as! String
		self.userName = dict["username"] as! String
		self.avatar = dict["avatar"] as! String
	}
	
}