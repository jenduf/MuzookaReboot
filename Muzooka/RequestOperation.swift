
//
//  RequestOperation.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/6/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation
import UIKit

class RequestOperation: NSObject, NSURLConnectionDataDelegate
{
	typealias ROCompletionHandler = (response: NSURLResponse, data: NSData, delegate: APIDelegate?, error: NSError?) -> Void
	
	var request: NSURLRequest?
	var autoRetryDelay: Double?
	var connection: NSURLConnection?
	var response: NSURLResponse?
	var accumulatedData: NSMutableData?
	var completionHandler: ROCompletionHandler?
	
	var delegate: APIDelegate?
	
	var executing: Bool = false
	var cancelled: Bool = false
	var finished: Bool = false
	var autoRetry: Bool = true
	
	class func initWithRequest(request: NSURLRequest, delegate: APIDelegate) -> RequestOperation
	{
		var operation: RequestOperation = RequestOperation.new()
		
		operation.delegate = delegate
		
		operation.request = request
		
		operation.autoRetryDelay = 5.0
		
		operation.connection = NSURLConnection(request: request, delegate: self, startImmediately: false)
		
		return operation
	}
	
	func start()
	{/*
        // Always check for cancellation before launching the task.
        if self.cancelled
        {
            // Must move the operation to the finished state if it is canceled.
            self.willChangeValueForKey("isFinished")
            
            self.finished = true
            
            self.didChangeValueForKey("isFinished")
            
            return
        }
        
        // If the operation is not canceled, begin executing the task.
        self.willChangeValueForKey("isExecuting")
        
        NSThread.detachNewThreadSelector("main", toTarget: self, withObject: nil)
        
        self.executing = true
        
        self.didChangeValueForKey("isExecuting")
        */
        
		if self.executing == false && self.cancelled == false
		{
			self.executing = true
			
			self.connection?.scheduleInRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
			
			self.connection?.start()
		}
	}
    
    func main()
    {
        self.willChangeValueForKey("isFinished")
        self.willChangeValueForKey("isExecuting")
        
        self.executing = false
        self.finished = true
        
        self.didChangeValueForKey("isExecuting")
        self.didChangeValueForKey("isFinished")
    }
	
	func cancel()
	{
		if self.cancelled == false
		{
			self.cancelled = true
			self.connection?.cancel()
			
			let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorCancelled, userInfo: nil)
			
			self.connection(self.connection!, didFailWithError: error)
		}
	}
	
	func finish()
	{
		if self.executing == true && self.finished == false
		{
			self.executing = false
			self.finished = true
		}
	}
	
	// MARK: NSURLConnectionDelegate Methods
	func connection(connection: NSURLConnection, didFailWithError error: NSError)
	{
		if self.autoRetry == true
		{
			self.connection = NSURLConnection(request: self.request!, delegate: self, startImmediately: false)
			
			let timeOffset = Int64(self.autoRetryDelay! * Double(NSEC_PER_SEC))
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, timeOffset), dispatch_get_main_queue())
				{
					self.start()
				}
		}
	}
	
	func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse)
	{
		self.response = response
	}
	
	/*func connection(connection: NSURLConnection, didSendBodyData bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int)
	{
		
	}*/
	
	func connection(connection: NSURLConnection, didReceiveData data: NSData)
	{
		if self.accumulatedData == nil
		{
			var length = Float(self.response!.expectedContentLength)
			var maxCapacity = max(0, length)
			self.accumulatedData = NSMutableData(capacity: Int(maxCapacity))
		}
		
		self.accumulatedData?.appendData(data)
	}
	
	func connectionDidFinishLoading(connection: NSURLConnection)
	{
		var error: NSError?
		
		let httpResponse = self.response as! NSHTTPURLResponse
		
		if ((httpResponse.statusCode / 100) >= 4)
		{
			error = NSError(domain: NSURLErrorDomain, code: httpResponse.statusCode, userInfo: nil)
			println("\(error)")
		}
		
		if self.completionHandler != nil
		{
			self.completionHandler!(response:self.response!, data: self.accumulatedData!, delegate: self.delegate!, error: error!)
		}
	}
    
    func isConcurrent() -> Bool
    {
        return true
    }
    
    func isExecuting() -> Bool
    {
        return self.executing
    }
    
    func isFinished() -> Bool
    {
        return self.finished
    }
}