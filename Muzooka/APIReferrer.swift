
//
//  APIReferrer.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/9/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

public struct APIReferrer
{
	public var type: ReferrerType = .None
	public var referrerID: Int = 0
	public var extra: String = ""
	public var isQueue: Bool = false
	public var isManual: Bool = false
	
	public enum ReferrerType: String
	{
		case None = ""
		case Charts = "charts"
		case PartnerCharts = "partnercharts"
		case Playlist = "playlist"
		case Band = "band"
		case Search = "search"
		case Song = "song"
		case Discovery = "discovery"
		case User = "user"
	}
	
	public enum ExtraInfo: String
	{
		case None = ""
		case Hot = "hot"
		case New = "new"
		case Top = "top"
		case Search = "SEARCH_TERM"
	}
	
	public init(type: ReferrerType, id: Int, extra: String, isQueue: Bool, isManual: Bool)
	{
		self.type = type
		self.referrerID = id
		self.extra = extra
		self.isQueue = isQueue
		self.isManual = isManual
	}
	
	func getParameterString() -> String
	{
		return "type=\(self.type.rawValue); id=\(self.referrerID); extra=\(self.extra); is_queue=\(self.isQueue); is_manual=\(self.isManual);"
	}
}