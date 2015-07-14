//
//  StackedGridLayout.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/3/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

protocol StackedGridLayoutDelegate: UICollectionViewDelegate
{
	func collectionView(collectionView: UICollectionView, layout cvl: UICollectionViewLayout, numberOfColumnsInSection section: Int) -> Int
	
	func collectionView(collectionView: UICollectionView, layout cvl: UICollectionViewLayout, sizeForItemWithWidth width: CGFloat, atIndexPath indexPath:NSIndexPath) -> CGSize
	
	func collectionView(collectionView: UICollectionView, layout cvl: UICollectionViewLayout, itemInsetsForSectionAtIndex section: Int) -> UIEdgeInsets
}

class StackedGridLayout: UICollectionViewLayout
{
	var headerHeight: CGFloat = 0
	
	var layoutDelegate: StackedGridLayoutDelegate?
	
	var sectionData = [StackedGridLayoutSection]()
	
	var height: CGFloat = 0
	
	override func prepareLayout()
	{
		super.prepareLayout()
		
		self.layoutDelegate = self.collectionView!.delegate as? StackedGridLayoutDelegate
		
		var currentOrigin = CGPoint.zeroPoint
		let numberOfSections = self.collectionView!.numberOfSections()
		
		var index = 0
		
		while index < numberOfSections
		{
			self.height += self.headerHeight
			currentOrigin.y = self.height
			
			let numberOfColumns = self.layoutDelegate!.collectionView(self.collectionView!, layout: self, numberOfColumnsInSection: index)
			
			let numberOfItems = self.collectionView?.numberOfItemsInSection(index)
			
			let itemInsets = self.layoutDelegate!.collectionView(self.collectionView!, layout: self, itemInsetsForSectionAtIndex: index)
			
			let section = StackedGridLayoutSection(origin: currentOrigin, width: self.collectionView!.bounds.size.width, columns: numberOfColumns, itemInsets: itemInsets) as StackedGridLayoutSection
			
			var jIndex = 0
			
			while jIndex < numberOfItems
			{
				let itemWidth = (section.columnWidth - section.itemInsets.left - section.itemInsets.right)
				
				let itemIndexPath = NSIndexPath(forItem: jIndex, inSection: index)
				
				let itemSize = self.layoutDelegate!.collectionView(self.collectionView!, layout: self, sizeForItemWithWidth: itemWidth, atIndexPath: itemIndexPath)
				
				section.addItem(itemSize, index: jIndex)
				
				jIndex++
			}
			
			self.sectionData.append(section)
			
			self.height += section.frame.size.height
			
			currentOrigin.y = self.height
			
			index++
		}
		
	}
	
	override func collectionViewContentSize() -> CGSize
	{
		return CGSize(width: self.collectionView!.width, height: self.height)
	}
	
	override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes!
	{
		let section = self.sectionData[indexPath.section] as StackedGridLayoutSection
		
		var attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
		attributes.frame = section.getFrameForItem(indexPath.item)
		
		return attributes
	}
	
	override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes!
	{
		let section = self.sectionData[indexPath.section] as StackedGridLayoutSection
		
		var attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, withIndexPath: indexPath)
		
		let sectionFrame = section.frame
		
		var headerFrame = CGRect(x: 0.0, y: sectionFrame.origin.y - self.headerHeight, width: sectionFrame.size.width, height: self.headerHeight)
		
		attributes.frame = headerFrame
		
		return attributes
	}
	
	override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]?
	{
		var attributes = [UICollectionViewLayoutAttributes]()
		
		var index = 0
		
		var total = self.sectionData.count
		
		while index < total
		{
			let section = self.sectionData[index] as StackedGridLayoutSection
			
			let sectionFrame = section.frame
			
			let headerFrame = CGRect(x: 0.0, y: (sectionFrame.origin.y - self.headerHeight), width: sectionFrame.size.width, height: self.headerHeight)
			
			if CGRectIntersectsRect(headerFrame, rect)
			{
				let indexPath = NSIndexPath(forItem: 0, inSection: index)
				let la = self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: indexPath)
				attributes.append(la)
			}
			
			if CGRectIntersectsRect(sectionFrame, rect)
			{
				var jIndex = 0
				
				while jIndex < section.numberOfItems
				{
					let frame = section.getFrameForItem(jIndex)
					
					if CGRectIntersectsRect(frame, rect)
					{
						let indexPath = NSIndexPath(forItem: jIndex, inSection: index)
						
						let la = self.layoutAttributesForItemAtIndexPath(indexPath)
						
						attributes.append(la)
					}
					
					jIndex++
				}
			}
			
			index++
		}
		
		return attributes
	}
	
}
