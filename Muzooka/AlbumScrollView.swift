//
//  AlbumScrollView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/13/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

protocol AlbumScrollViewDataSource
{
	func numberOfItemsInScrollView(scrollView: AlbumScrollView) -> Int
	
	func viewForAlbumAtIndex(index: Int) -> AlbumArtView
}

protocol AlbumScrollViewDelegate
{
	func scrollItemWidth(scrollView: AlbumScrollView) -> CGFloat?
	
	func numberOfVisibleItemsInScrollView(scrollView: AlbumScrollView) -> Int?
	
	func albumScrollViewDidScroll(scrollView: AlbumScrollView)
	
	func albumScrollViewDidDisplayItemAtIndex(scrollView: AlbumScrollView) -> Int?
	
	func albumScrollViewDidSelectItemAtIndex(albumScrollView: AlbumScrollView) -> Int?
}


class AlbumScrollView: UIScrollView
{
	var visibleCardIndex: Int = 0
	var visibleCardsOffset: Int = 0
	
	var containerView: UIView?
	
	var albumScrollDataSource: AlbumScrollViewDataSource?
	{
		didSet
		{
			self.reloadData()
		}
	}

	var visibleAlbumViews = [AlbumArtView]()
	{
		didSet
		{
			//self.setUpScroll()
		}
	}
	
	required init(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		
		self.setUpContainer()
	}
	
	func setUpContainer()
	{
		self.containerView = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height))
		self.addSubview(self.containerView!)
	}
	
	func reloadData()
	{
		self.reloadDataAtStartIndex(0)
	}
	
	func reloadDataAtStartIndex(index: Int)
	{
		
		//let itemWidth = self.albumScrollDataSource?.scrollItemWidth(self)
		
		for artView in self.visibleAlbumViews
		{
			artView.removeFromSuperview()
		}
		
		self.visibleAlbumViews.removeAll()
		
		
		if self.albumScrollDataSource == nil
		{
			return
		}
		
		let numberOfCards = self.albumScrollDataSource?.numberOfItemsInScrollView(self)
		
		if numberOfCards == 0
		{
			return
		}
		
		let adjustedCardCount = min(numberOfCards!, Constants.SCROLL_ALBUM_MAX_VISIBLE)
		
		var start = index - adjustedCardCount / 2
		
		var end = index + adjustedCardCount / 2
		
		if start < 0
		{
			start = 0
			end = adjustedCardCount
		}
		
		if (index + (adjustedCardCount / 2 - 1)) >= numberOfCards
		{
			start = numberOfCards! - adjustedCardCount
			end = numberOfCards!
		}
		
		for var i = start; i < end; i++
		{
			let album = self.albumScrollDataSource?.viewForAlbumAtIndex(i)
			let visible: Bool = (i >= index)
			
			var center: CGPoint = CGPoint.zeroPoint
			
			if visible == true
			{
				center = CGPoint(x: Constants.PADDING + self.containerView!.width / 2, y: self.containerView!.height / 2)
			}
			else
			{
				let xOffset = CGFloat(arc4random()) % Constants.SIDE_PADDING - Constants.PADDING
				
				center = CGPoint(x: self.containerView!.width / 2 + xOffset, y: Constants.SIDE_PADDING * 2 - album!.height / 2)
			}
			
			let radians = CGFloat(arc4random()) % Constants.SIDE_PADDING - Constants.PADDING
			let angle = (CGFloat(M_PI) * (radians) / 180.0)
			
			album?.layer.setAffineTransform(CGAffineTransformMakeRotation(angle))
			album?.center = center
			
			let offset = i - start
			//let zIndex = visible ?
			
			self.containerView!.insertSubview(album!, atIndex: 0)
			
			self.visibleAlbumViews.append(album!)
		}
		
		self.visibleCardIndex = index - start
		self.visibleCardsOffset = start
	}
	
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
