
//
//  APIRequestParameter.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/18/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public class APIRequestParameter: NSObject
{
	public var key: String!
	
	public var value: AnyObject
    
    func getValue() -> String
    {
        var val = ""
        
        if let str = self.value as? String
        {
            val = str
        }
        else if self.value.description != nil
        {
            val = self.value.description
        }
        
        return val
    }
    
    func stringValue() -> String
    {
        var v = self.getValue()
        if self.key == nil
        {
            return v.escaped
        }
        
        return "\(self.key.escaped)=\(self.value.escaped)"
    }
}