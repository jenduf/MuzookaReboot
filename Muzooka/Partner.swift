//
//  Partner.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public class Partner
{
	public let partnerID: Int
	public let name: String
	public let subdomain: String
	public let partnerLogo: String?
	public let banner: String
	public let descriptionShort: String
	public let descriptionLong: String
	
	public init(dict: NSDictionary)
	{
		self.partnerID = dict["partner_id"] as! Int
		self.name = dict["name"] as! String
		self.subdomain = dict["subdomain"] as! String
		self.partnerLogo = dict["partnerlogo"] as? String
		self.descriptionShort = dict["description_short_mobile"] as! String
		self.descriptionLong = dict["description_long"] as! String
		self.banner = dict["bannermobile"] as! String
	}
	
}