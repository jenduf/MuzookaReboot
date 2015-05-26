
//
//  APIDelegate.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

protocol APIDelegate
{
	func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject)
	func apiManagerDidReturnError(apiManager: APIManager, error: String)
	func apiManagerDidReturnNeedsAuthenticatedUser(apiManager: APIManager)
}