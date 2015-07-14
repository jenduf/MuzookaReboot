//
//  StackedGridLayoutSection.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/3/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

public class StackedGridLayoutSection: NSObject
{
	var frame: CGRect = CGRect.zeroRect
	var itemInsets: UIEdgeInsets = UIEdgeInsetsZero
	public var columnWidth: CGFloat = 0
	var numberOfItems: Int = 0
	var columnHeights = [CGFloat]()
	var indexToFrameMap = [ Int: CGRect ]()
	
	var shortestColumnHeight = CGFloat.max
	var shortestColumnIndex = 0
	
	init(origin: CGPoint, width: CGFloat, columns: Int, itemInsets: UIEdgeInsets)
	{
		self.frame = CGRect(x: origin.x, y: origin.y, width: width, height: 0.0)
		self.itemInsets = itemInsets
		self.columnWidth = CGFloat(floorf(Float(width) / Float(columns)))
		
		var index = 0
		while index < columns
		{
			self.columnHeights.append(0.0)
			
			index++
		}
	}
	
	func addItem(size: CGSize, index: Int)
	{
		var index = 0
		
		while index < self.columnHeights.count
		{
			let value = self.columnHeights[index]
			
			let thisHeight = CGFloat(value)
			
			if thisHeight < self.shortestColumnHeight
			{
				self.shortestColumnHeight = thisHeight
				self.shortestColumnIndex = index
			}
			
			index++
		}
		
		var newFrame = CGRect(x: self.frame.origin.x + (self.columnWidth * CGFloat(self.shortestColumnIndex)) + self.itemInsets.left, y: (self.frame.origin.y + self.shortestColumnHeight + self.itemInsets.top), width: size.width, height: size.height)
		
		self.indexToFrameMap.updateValue(newFrame, forKey: index)
		
		if newFrame.maxY > self.frame.maxY
		{
			self.frame.size.height = (newFrame.maxY - self.frame.origin.y) + self.itemInsets.bottom
		}
		
		self.columnHeights.removeAtIndex(self.shortestColumnIndex)
		self.columnHeights.insert((self.shortestColumnHeight + size.height + self.itemInsets.bottom), atIndex: self.shortestColumnIndex)
	}
	
	func getFrameForItem(index: Int) -> CGRect
	{
		var rectValue = self.indexToFrameMap[index]
		return rectValue!
	}
   
}
