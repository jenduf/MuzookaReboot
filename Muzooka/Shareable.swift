
//
//  Shareable.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/17/15.
//  Copyright (c) 2015 com.muzooka. All rights reserved.
//

protocol Shareable
{
	func getItemID() -> Int
	func getItemName() -> String
	func getActionItems() -> [MenuAction]
	func getShareDetails() -> String
	func getShareURL() -> NSURL
	func shareableType() -> MediaType
}
