
//
//  SearchDetails.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/2/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public class SearchDetails
{
	public var searchTerm: String
	public var searchItems: [SearchItem]
	
	public init(term: String, items: [SearchItem])
	{
		self.searchTerm = term
		self.searchItems = items
	}
}