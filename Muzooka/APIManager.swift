
//
//  APIManager.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/4/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation
import UIKit

public class APIManager: NSObject, NSURLSessionDelegate, NSURLSessionDataDelegate
{
	private var session: NSURLSession?
	private var currentTask: NSURLSessionTask?
	private var responseData: NSMutableData?
	private var response: NSHTTPURLResponse?
	private var delegate: APIDelegate?
	var apiRequest: APIRequest?
	
	class var sharedManager: APIManager
	{
		struct SharedInstance
		{
			static let instance = APIManager()
		}
		
		return SharedInstance.instance
	}
	
	var authToken: String?
	{
		didSet
		{
			NSUserDefaults.standardUserDefaults().setObject(authToken, forKey: Constants.AUTH_TOKEN_KEY)
		}
	}

	public override init()
	{
		super.init()
		
		self.authToken = NSUserDefaults.standardUserDefaults().objectForKey(Constants.AUTH_TOKEN_KEY) as? String
	}
	
	func configureSession() -> NSURLSession
	{
		let config = NSURLSessionConfiguration.defaultSessionConfiguration()
		
		let newSession = NSURLSession(configuration: config, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
		
		return newSession
	}
	
	// MARK: Parse Helpers
	func parseJSONResponse(json: NSData?) -> AnyObject?
	{
		if json == nil
		{
			return nil
		}
		
		var error: NSError?
		
		let data: AnyObject! = NSJSONSerialization.JSONObjectWithData(json!, options: NSJSONReadingOptions.AllowFragments, error: &error)
		
		if error != nil
		{
			println("JSON ERROR: \(error)")
			return nil
		}
		
		return data
	}
	
	func dictionaryToJSON(dictionary: NSDictionary) -> NSData
	{
		var error: NSError?
		var jsonData: NSData = NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions.PrettyPrinted, error: &error)!
		
		if jsonData.length > 0 && error == nil
		{
			println("Successful serialization of dictionary /(jsonData)")
		}
		else if jsonData.length == 0 && error == nil
		{
			println("No data was returned after serialization")
		}
		else if error != nil
		{
			println("An error happened = /(error)")
		}
		
		return jsonData
	}
	
	// MARK: Get API Request
	func getAPIRequestForDelegate(apiRequest: APIRequest, delegate: APIDelegate, apiReferrer: APIReferrer? = nil, postData:NSDictionary? = nil, offset: Int = 0, count: Int = 0)
	{
		self.apiRequest = apiRequest
		
		self.delegate = delegate
		
		if(self.apiRequest?.requiresAuthentication == true && self.authToken == nil)
		{
			self.delegate?.apiManagerDidReturnNeedsAuthenticatedUser(self)
			
			return
		}
		
		var requestURL = "\(Constants.API_URL)/\(apiRequest.getURLWithParameters())"//getURLWithAppendedID(appendedString))"
		
		if offset > 0 || count > 0
		{
			requestURL.extend("?offset=\(offset)&count=\(count)")
		}
		
		var data:NSData?
		
		if postData != nil
		{
			data = self.dictionaryToJSON(postData!)
			//let emailString = parameters["email"] as! String
			//var passString = parameters["password"] as! String
			//var paramString = "email=\(emailString)&password=\(passString)"
			//postData = parameters?.dataUsingEncoding(NSUTF8StringEncoding)
		}
		
		println("original url: \(requestURL)")
		
		let strippedString = requestURL.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil) //String(filter(requestURL.generate()) { $0 != " "})
		
		println("stripped url: \(strippedString)")
		
		let apiString = (apiReferrer != nil ? apiReferrer!.getParameterString() : "")
		
		self.startRequest(strippedString, method: apiRequest.httpMethod, postData: data, apiReferrer: apiString)
	}
	
	// MARK: Make the Request
	func startRequest(requestStr: String, method: String, postData: NSData?, apiReferrer: String = "")
	{
		if self.currentTask != nil
		{
			return
		}
		
		if self.session == nil
		{
			self.session = self.configureSession()
		}
		
		println("\n REQUEST: \(requestStr)")
		
		var request = NSMutableURLRequest(URL: NSURL(string: requestStr)!)
		request.HTTPMethod = method
		
		if postData != nil
		{
			var jsonString:NSString = NSString(data: postData!, encoding: NSUTF8StringEncoding)!
			println("\n POST DATA: \(jsonString)")
			request.HTTPBody = postData
		}
		
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.setValue("application/json", forHTTPHeaderField: "Accept")
		request.setValue("Muzooka-iOS-App", forHTTPHeaderField: "Browser")
		request.setValue("iOS", forHTTPHeaderField: "OS")
		request.setValue(UIDevice.currentDevice().systemVersion, forHTTPHeaderField: "Version")
		
		if !apiReferrer.isEmpty
		{
			request.setValue(apiReferrer, forHTTPHeaderField: "Muzooka-Referrer")
		}
		
		// authenticate if logged in
		if self.authToken != nil
		{
			request.setValue(self.authToken, forHTTPHeaderField: "Muzooka-Auth-Token")
		}
		
		println("REFERRER VALUES: \(apiReferrer)")
		
		self.responseData = NSMutableData.new()
		
		self.currentTask = self.session?.dataTaskWithRequest(request)
		
		self.currentTask?.resume()
		
		/*
		// to queue results
		var operation = RequestOperation.initWithRequest(request, delegate: self.delegate!)
		
		operation.completionHandler =
		{
			(response: NSURLResponse, data: NSData, delegate: APIDelegate?, error: NSError?) in
			
			if error != nil
			{
				println("REQUEST ERROR: \(error)")
				
				if delegate != nil
				{
					delegate?.apiManagerDidReturnError(self, error: error!.localizedDescription)
				}
			}
			else
			{
				var str:NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
				
				println("RESPONSE RECEIVED: \(str)")
				
				if self.delegate != nil
				{
					var jsonData: AnyObject? = self.parseJSONResponse(data)
					
					if jsonData != nil
					{
						self.delegate?.apiManagerDidReturnData(self, data: jsonData!)
					}
				}
				
			}
				
		}*/
		
		
	}
	
	/*func handleRequest(request: APIRequest, queryStringArguments: [String: String])
	{
		
	}
	
	func handleRequest(request: APIRequest, jsonBody: JSON)
	{
		
	}*/
	
	// MARK: NSURLSessionTaskDelegate Methods
	public func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void)
	{
		self.responseData?.length = 0
		
		self.response = response as? NSHTTPURLResponse
		
		var status = self.response?.statusCode
		
		println("RESPONSE STATUS CODE: \(status)")
		
		if status == Constants.HTTP_CODE_SUCCESS || status == Constants.HTTP_CODE_CREATE || status == Constants.HTTP_CODE_NO_CONTENT
		{
			completionHandler(NSURLSessionResponseDisposition.Allow)
		}
		else
		{
			var statusMessage = "Received bad status code: \(status)"
			
			println("STATUS MESSAGE: \(statusMessage)")
			
			if self.delegate != nil
			{
				self.delegate?.apiManagerDidReturnError(self, error: statusMessage)
			}
		}
		
		self.currentTask = nil
	}
	
	public func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData)
	{
		self.responseData?.appendData(data)
	}
	
	public func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?)
	{
		self.currentTask = nil
		
		if error != nil
		{
			println("REQUEST ERROR: \(error)")
			
			if self.delegate != nil
			{
				self.delegate?.apiManagerDidReturnError(self, error: error!.localizedDescription)
			}
		}
		else
		{
			
			var jsonData:AnyObject?
			
			if self.responseData?.length > 0
			{
				var str:NSString = NSString(data: self.responseData!, encoding: NSUTF8StringEncoding)!
			
				println("RESPONSE RECEIVED: \(str)")
				
				jsonData = self.parseJSONResponse(self.responseData)
			}
			
			if self.delegate != nil
			{
				self.delegate?.apiManagerDidReturnData(self, data: jsonData)
			}
			
		}
		
	}
	
}