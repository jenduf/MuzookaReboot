
//
//  String+Escape.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 8/24/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

extension String
{
    /**
    A simple extension to the String object to encode it for web request.
    
    :returns: Encoded version of of string it was called as.
    */
    var escaped: String
    {
        return CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,self,"[].",":/?&=;+!@#$()',*",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)) as! String
    }
}
