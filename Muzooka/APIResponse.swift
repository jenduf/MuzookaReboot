
//
//  APIResponse.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 8/24/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public class APIRequestSerializer: NSObject
{
    let contentTypeKey = "Content-Type"
    
    /// headers for the request.
    public var headers = Dictionary<String, String>()
    
    // encoding for the request
    public var stringEncoding: UInt = NSUTF8StringEncoding
    
    /// Send request if using cellular network or not. Defaults to true.
    public var allowsCellularAccess = true
    
    // If the request should handle cookies of not. Defaults to true.
    public var shouldHandleCookies = true
    
    // If the request should use piplining or not. Defaults to false.
    public var shouldUsePipelining = false
    
    // How long the timeout interval is. Defaults to 60 seconds.
    public var timeoutInterval: NSTimeInterval = 60
    
    /// Set the request cache policy. Defaults to UseProtocolCachePolicy.
    public var cachePolicy: NSURLRequestCachePolicy = NSURLRequestCachePolicy.UseProtocolCachePolicy
    
    /// Set the network service. Defaults to NetworkServiceTypeDefault.
    public var networkServiceType = NSURLRequestNetworkServiceType.NetworkServiceTypeDefault
    
    
    /// Initializes a new APIRequestSerializer Object.
    public override init()
    {
        super.init()
    }
    
    /**
    Creates a new NSMutableURLRequest object with configured options.
    
    :param: url The url you would like to make a request to.
    :param: method The HTTP method/verb for the request.
    
    :returns: A new NSMutableURLRequest with said options.
    */
    public func newRequest(url: NSURL, method: APIRequest.HTTPMethod) -> NSMutableURLRequest
    {
        var request = NSMutableURLRequest(URL: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        request.HTTPMethod = method.rawValue
        request.cachePolicy = self.cachePolicy
        request.timeoutInterval = self.timeoutInterval
        request.HTTPShouldHandleCookies = self.shouldHandleCookies
        request.HTTPShouldUsePipelining = self.shouldUsePipelining
        request.networkServiceType = self.networkServiceType
        
        for (key, val) in self.headers
        {
            request.addValue(val, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    /**
    Creates a new NSMutableURLRequest object with configured options.
    
    :param: url The url you would like to make a request to.
    :param: method The HTTP method/verb for the request.
    :param: parameters The parameters are HTTP parameters you would like to send.
    
    :returns: A new NSMutableURLRequest with said options or an error.
    */
    public func createRequest(url: NSURL, method: APIRequest.HTTPMethod, parameters: Dictionary<String, AnyObject>?) -> (request: NSURLRequest, error: NSError?)
    {
        var request = self.newRequest(url, method: method)
        var isMulti = false
        
        // do a check for upload objects to see if we are multi form
        if let params = parameters
        {
            isMulti = isMultiForm(params)
        }
        
        if isMulti
        {
           /* if (method != .POST && method != .PUT && method != .PATCH)
            {
                request.HTTPMethod = APIRequest.HTTPMethod.POST.rawValue
            }*/
            
            var boundary = "Boundary+\(arc4random())\(arc4random())"
            
            if parameters != nil
            {
                let jsonObj = self.dictionaryToJSON(parameters!)
                
                request.HTTPBody = jsonObj.data
            }
            
            if request.valueForHTTPHeaderField(contentTypeKey) == nil
            {
                request.setValue("multipart/form-data; boundary = \(boundary)", forHTTPHeaderField: contentTypeKey)
            }
            
            return (request, nil)
        }
        
        var queryString = ""
        
        if parameters != nil
        {
            queryString = self.stringF
        }
    }
    
    public func isMultiForm(params: Dictionary<String, AnyObject>) -> Bool
    {
        
    }
    
    public func stringFromParameters(parameters: Dictionary<String, AnyObject>) -> String
    {
        return join("&", map(serializeObject(parameters, key: nil),
        {
            (pair) in
                return pair.stringValue()
        }))
    }
    
    ///the method to serialized all the objects
    func serializeObject(object: AnyObject,key: String?) -> Array<HTTPPair> {
        var collect = Array<HTTPPair>()
        if let array = object as? Array<AnyObject> {
            for nestedValue : AnyObject in array {
                collect.extend(self.serializeObject(nestedValue,key: "\(key!)[]"))
            }
        } else if let dict = object as? Dictionary<String,AnyObject> {
            for (nestedKey, nestedObject: AnyObject) in dict {
                var newKey = key != nil ? "\(key!)[\(nestedKey)]" : nestedKey
                collect.extend(self.serializeObject(nestedObject,key: newKey))
            }
        } else {
            collect.append(HTTPPair(value: object, key: key))
        }
        return collect
    }

    //create a multi form data object of the parameters
    func dataFromParameters(parameters: Dictionary<String,AnyObject>,boundary: String) -> NSData {
        var mutData = NSMutableData()
        var multiCRLF = "\r\n"
        var boundSplit =  "\(multiCRLF)--\(boundary)\(multiCRLF)".dataUsingEncoding(self.stringEncoding)!
        var lastBound =  "\(multiCRLF)--\(boundary)--\(multiCRLF)".dataUsingEncoding(self.stringEncoding)!
        mutData.appendData("--\(boundary)\(multiCRLF)".dataUsingEncoding(self.stringEncoding)!)
        
        let pairs = serializeObject(parameters, key: nil)
        let count = pairs.count-1
        var i = 0
        for pair in pairs {
            var append = true
            if let upload = pair.getUpload() {
                if let data = upload.data {
                    mutData.appendData(multiFormHeader(pair.k, fileName: upload.fileName,
                        type: upload.mimeType, multiCRLF: multiCRLF).dataUsingEncoding(self.stringEncoding)!)
                    mutData.appendData(data)
                } else {
                    append = false
                }
            } else {
                let str = "\(multiFormHeader(pair.k, fileName: nil, type: nil, multiCRLF: multiCRLF))\(pair.getValue())"
                mutData.appendData(str.dataUsingEncoding(self.stringEncoding)!)
            }
            if append {
                if i == count {
                    mutData.appendData(lastBound)
                } else {
                    mutData.appendData(boundSplit)
                }
            }
            i++
        }
        return mutData
    }
    
    func dictionaryToJSON(dictionary: NSDictionary) -> (data: NSData, error: NSError?)
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
        
        return (jsonData, error)
    }
}

public class APIResponse
{
    /// The header values in HTTP response.
    public var headers: Dictionary<String, String>?
    
    /// The mime type of the HTTP response.
    public var mimeType: String?
    
    /// The body or response data of the HTTP response.
    public var responseObject: AnyObject?
    
    /// The status code of the HTTP response.
    public var statusCode: Int?
    
    /// The URL of the HTTP response.
    public var url: NSURL?
    
    /// The Error of the HTTP response (if there was one).
    public var error: NSError?
    
    ///Returns the response as a string
    public var text: String?
    {
        if let d = self.responseObject as? NSData
        {
            return NSString(data: d, encoding: NSUTF8StringEncoding) as? String
        }
        else if let val: AnyObject = self.responseObject
        {
            return "\(val)"
        }
        
        return nil
    }
    
    //get the description of the response
    public var description: String
    {
        var buffer = ""
        
        if let u = self.url
        {
            buffer += "URL: \n\(u)\n\n"
        }
        
        if let code = self.statusCode
        {
            buffer += "Status Code: \n\(code)\n\n"
        }
        
        if let heads = self.headers
        {
            buffer += "Headers: \n"
            
            for (key, value) in heads
            {
                buffer += "\(key): \(value)\n"
            }
            
            buffer += "\n"
        }
        
        if let s = self.text
        {
            buffer += "Payload: \n\(s)\n"
        }
        
        return buffer
    }
    
    // MARK: Parse Helpers
    public func parseJSONResponse(json: NSData?) -> (data: AnyObject?, error: NSError?)
    {
        if json == nil
        {
            return (nil, nil)
        }
        
        var error: NSError?
        
        let data: AnyObject! = NSJSONSerialization.JSONObjectWithData(json!, options: NSJSONReadingOptions.AllowFragments, error: &error)
        
        if error != nil
        {
            println("JSON ERROR: \(error)")
            //return nil
        }
        
        return (data, error)
    }
}