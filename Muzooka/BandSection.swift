
//
//  BandSection.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/28/15.
//  Copyright (c) 2015 com.muzooka. All rights reserved.
//

import Foundation

public enum BandSection: Int
{
    case About = 0, Bio = 1, Members = 2, Social = 3

    public func stringValue() -> String
    {
        switch self
        {
            case .About:
                return ""
                
            case .Bio:
                return "Bio"
                
            case .Members:
                return "Members"
                
            case .Social:
                return "Social"
        }
    }
    
    public func getCellIdentifierForSection() -> String
    {
        switch self
        {
            case .About:
                return Constants.BAND_INFO_CELL_IDENTIFIER
            
            case .Bio:
                return Constants.BAND_INFO_BIO_CELL_IDENTIFIER
            
            case .Members:
                return Constants.BAND_INFO_MEMBERS_CELL_IDENTIFIER
            
            case .Social:
                return Constants.BAND_INFO_SOCIAL_CELL_IDENTIFIER
        }
    }
    
    public static let sections: [BandSection] =
    [
        .About, .Bio, .Members, .Social
    ]
}