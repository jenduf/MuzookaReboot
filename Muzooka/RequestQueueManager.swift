
//
//  RequestQueueManager.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/6/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

let mainQueue = RequestQueueManager()

class RequestQueueManager: NSObject
{
	let maxConcurrentRequestCount = 2
	let allowDuplicateRequests = false
	
	var operations = [RequestOperation]()
	
	var queueMode: QueueMode = QueueMode.FirstInFirstOut
	
	var suspended: Bool = false
	{
		didSet
		{
			self.dequeueOperations()
		}
	}
	
	
	func requestCount() -> Int
	{
		return self.operations.count
	}
	
	func requests() -> NSArray
	{
		return self.operations
	}
	
	func dequeueOperations()
	{
		if self.suspended == false
		{
			var count = min(self.operations.count, self.maxConcurrentRequestCount)
			
			for var i = 0; i < count; i++
			{
				var ro = self.operations[i] as RequestOperation
				ro.start()
			}
		}
	}
	
	func addOperation(operation: RequestOperation)
	{
		if self.allowDuplicateRequests == true
		{
			for op in self.operations.reverse()
			{
				if op.request!.isEqual(operation.request)
				{
					op.cancel()
				}
			}
		}
		
		var index = 0
		if self.queueMode == QueueMode.FirstInFirstOut
		{
			index = self.operations.count
		}
		else
		{
			for op in self.operations
			{
				if op.executing == false
				{
					break
				}
				
				index++
			}
		}
		
		if index < self.operations.count
		{
			self.operations.insert(operation, atIndex: index)
		}
		else
		{
			self.operations.append(operation)
		}
		
		self.dequeueOperations()
	}
	
	func addRequest(request: NSURLRequest, delegate: APIDelegate)
	{
		var operation = RequestOperation.initWithRequest(request, delegate: delegate)
		self.addOperation(operation)
	}
	
	func cancelRequest(request: NSURLRequest)
	{
		for operation in self.operations.reverse()
		{
			if operation.request == request
			{
				operation.cancel()
			}
		}
	}
	
	func cancelAllRequests()
	{
		for operation in self.operations.reverse()
		{
			operation.cancel()
		}
	}
}