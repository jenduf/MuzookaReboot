//
//  SegmentViewDelegate.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

protocol SegmentViewDelegate
{
	func segmentViewDidSelectViewIndex(segmentView: SegmentView, index: Int)
}