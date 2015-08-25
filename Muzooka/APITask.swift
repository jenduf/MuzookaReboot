//
//  APITask.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 8/24/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

typealias APICompletionHandler = (response: NSURLResponse, data: NSData, error: NSError?) -> Void

/// Configures NSURLSession Request for HTTPOperation. Also provides convenience methods for easily running HTTP Request.
public class APITask: NSObject, NSURLSessionDelegate, NSURLSessionTaskDelegate
{
    var backgroundTaskMap = { String : APIBlocks }
    
    public var baseURL: String?
    //This gets called on auth challenges. If nil, default handling is used.
    //Returning nil from this method will cause the request to be rejected and cancelled
    public var auth: ((NSURLAuthenticationChallenge) -> NSURLCredential?)?
    
    // MARK: Public Methods
    
    public override init()
    {
        super.init()
    }
    
    /**
    Creates an APIOperation that can be scheduled on a NSOperationQueue. Called by convenience HTTP verb methods below.
    
    :param: url The url you would like to make a request to.
    :param: method The HTTP method/verb for the request.
    :param: parameters The parameters are HTTP parameters you would like to send.
    :param: completionHandler The closure that is run when a HTTP Request finished.
    
    :returns: A freshly constructed APIOperation to add to your NSOperationQueue.
    */
    public func create(url: String, method: APIRequest.HTTPMethod, parameters: Dictionary<String, AnyObject>!, completionHandler: ((APIResponse) -> Void)!) -> APIOperation?
    {
        var serialResponse = APIResponse()
        let serialReq = self.createRequest(url, method: method, parameters: parameters)
        
        if let err = serialReq.error
        {
            if let handler = completionHandler
            {
                serialResponse.error = err
                handler(serialResponse)
            }
            
            return nil
        }
        
        let opt = APIOperation()
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config, delegate: self, delegateQueue: nil)
        let task = session.dataTaskWithRequest(serialReq.request, completionHandler:
            {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                    if let handler = completionHandler
                    {
                        if let hResponse = response as? NSHTTPURLResponse
                        {
                            serialResponse.headers = hResponse.allHeaderFields as? Dictionary<String,String>
                            serialResponse.mimeType = hResponse.MIMEType
                            serialResponse.statusCode = hResponse.statusCode
                            serialResponse.url = hResponse.URL
                        }
                        
                        serialResponse.error = error
                        
                        if let d = data
                        {
                            let jsonObj = serialResponse.parseJSONResponse(d as NSData)
                            
                            if let json: AnyObject = jsonObj.data
                            {
                                serialResponse.responseObject = json
                            }
                                
                            if let err = jsonObj.error
                            {
                                serialResponse.error = err
                            }
                            
                        }
                        
                        handler(serialResponse)
                    }
                
                opt.finish()
            
            })
        
        opt.task = task
        
        return opt
    }
    
    //MARK: Private Helper Methods
    
    /**
    Creates and starts a HTTPOperation to download a file in the background.
    
    :param: url The url you would like to make a request to.
    :param: method The HTTP method/verb for the request.
    :param: parameters The parameters are HTTP parameters you would like to send.
    
    :returns: A NSURLRequest from configured requestSerializer.
    */
    public func createRequest(url: String, method: APIRequest.HTTPMethod, parameters: Dictionary<String, AnyObject>!) -> (request: NSURLRequest, error: NSError?)
    {
        var urlVal = url
        
        if let base = self.baseURL where !url.hasPrefix("http")
        {
            var split = url.hasPrefix("/") ? "" : "/"
            urlVal = "\(base)\(split)\(url)"
        }
        
        if let encoded = urlVal.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        {
            if let u = NSURL(string: encoded)
            {
                return self.req
            }
        }
    }
}

/// Holds the blocks of the background task.
public class APIBlocks
{
    var completionHandler: ((APIResponse) -> Void)?
    var progress: ((Double) -> Void)?
    
    /**
    Initializes a new Background Block
    
    :param: completionHandler The closure that is run when a HTTP Request finished.
    :param: progress The closure that is run on the progress of a HTTP Upload or Download.
    */
    
    init(completionHandler: ((APIResponse) -> Void)?, progress: ((Double) -> Void)?)
    {
        self.completionHandler = completionHandler
        self.progress = progress
    }

}