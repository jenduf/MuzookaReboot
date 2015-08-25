
//
//  RequestOperation.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/6/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation
import UIKit

class RequestOperation: NSOperation, NSURLConnectionDataDelegate
{
	typealias ROCompletionHandler = (response: NSURLResponse, data: NSData, delegate: APIDelegate?, error: NSError?) -> Void
    typealias ROAuthenticationChallengeHandler = (challenge: NSURLAuthenticationChallenge) -> Void
	
	var request: NSURLRequest?
	var autoRetryDelay: Double?
	var connection: NSURLConnection?
	var response: NSURLResponse?
	var accumulatedData: NSMutableData?
	var completionHandler: ROCompletionHandler?
	
	var delegate: APIDelegate?

	var autoRetry: Bool = true
    
    var autoRetryErrorCodes: NSSet
    {
        get
        {
             return NSSet(objects: NSURLErrorTimedOut, NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost, NSURLErrorDNSLookupFailed, NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost)
        }
            
    }

    init(request: NSURLRequest, delegate: APIDelegate)
    {
        super.init()
        
        self.request = request
        self.delegate = delegate
        
        self.autoRetryDelay = Constants.AUTO_RETRY_TIMEOUT
        
        self.connection = NSURLConnection(request: request, delegate: self, startImmediately: false)
    }
	
	/*class func initWithRequest(request: NSURLRequest, delegate: APIDelegate) -> RequestOperation
	{
		var operation: RequestOperation = RequestOperation.new()
		
		operation.delegate = delegate
		
		operation.request = request
		
		operation.autoRetryDelay = 5.0
		
		operation.connection = NSURLConnection(request: request, delegate: self, startImmediately: false)
		
		return operation
	}*/
	
	override func start()
	{
        // Always check for cancellation before launching the task.
        if self.executing == false && self.cancelled == false
        {
            // If the operation is not canceled, begin executing the task.
            self.willChangeValueForKey("isExecuting")
            self.executing = true
            self.connection?.scheduleInRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
            self.connection?.start()
            self.didChangeValueForKey("isExecuting")
        }
	}
    
    func cancel()
    {
        if self.cancelled == false
        {
            self.willChangeValueForKey("isCancelled")
            self.cancelled = true
            self.connection?.cancel()
            self.didChangeValueForKey("isCancelled")
            
            let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorCancelled, userInfo: nil)
            
            self.connection(self.connection!, didFailWithError: error)
        }
    }
    
    func finish()
    {
        if self.executing == true && self.finished == false
        {
            self.willChangeValueForKey("isExecuting")
            self.willChangeValueForKey("isFinished")
            self.executing = false
            self.finished = true
            self.didChangeValueForKey("isFinished")
            self.didChangeValueForKey("isExecuting")
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
	
	
	// MARK: NSURLConnectionDelegate Methods
	func connection(connection: NSURLConnection, didFailWithError error: NSError)
	{
		if self.autoRetry == true && self.autoRetryErrorCodes?.containsObject(error.code) == true
		{
			self.connection = NSURLConnection(request: self.request!, delegate: self, startImmediately: false)
			
			let timeOffset = Int64(self.autoRetryDelay! * Double(NSEC_PER_SEC))
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, timeOffset), dispatch_get_main_queue())
				{
					self.start()
				}
		}
        else
        {
            self.finish()
            
            if self.completionHandler != nil
            {
                self.completionHandler(self.response, self.accumulatedData, self.delegate, error)
            }
        }
	}
    
    func connection(connection: NSURLConnection, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge)
    {
        if self.auth
        
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