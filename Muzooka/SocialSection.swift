//
//  SocialSection.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/28/15.
//  Copyright (c) 2015 com.muzooka. All rights reserved.
//

import Foundation

public enum SocialSection: Int
{
    case Facebook = 0, Twitter = 1, Email = 2
    
    public func stringValue() -> String
    {
        switch self
        {
            case .Facebook:
                return "social_facebook"
                
            case .Twitter:
                return "social_twitter"
                
            case .Email:
                return "social_link"

        }
    }
}