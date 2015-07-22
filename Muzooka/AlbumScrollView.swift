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


class AlbumScrollView: UIScrollView, UIScrollViewDelegate
{
	/*
	var visibleCardIndex: Int = 0
	var visibleCardsOffset: Int = 0
	var itemWidth: CGFloat = 0
	var scrollOffset: CGFloat = 0
	
	var containerView: UIView?
	
	var albumScrollDataSource: AlbumScrollViewDataSource?
	{
		didSet
		{
			//self.layoutItems()
		}
	}
	
	var albumScrollDelegate: AlbumScrollViewDelegate?
	{
		didSet
		{
			//self.layoutItems()
		}
	}
	
	var albumViews = [AlbumArtView]()
	{
		didSet
		{
			
		}
	}

	var visibleAlbumViews = [AlbumArtView]()
	{
		didSet
		{
			
		}
	}
	
	required init(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		
		self.setUpContainer()
	}
	
	override func layoutSubviews()
	{
		super.layoutSubviews()
		
		self.containerView!.frame = self.bounds
		
		//self.layoutItems()
	}
	
	func setUpContainer()
	{
		self.containerView = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height))
		self.addSubview(self.containerView!)
	}
	
	func layoutItems()
	{
		// record current item width
		let prevItemWidth = self.itemWidth
		
		//self.itemWidth = self.albumScrollDelegate!.scrollItemWidth(self)!
		if self.albumViews.count < Constants.SCROLL_ALBUM_MAX_VISIBLE
		{
			self.loadViewAtIndex(self.albumViews.count)
		}
		
		//let itemView: AlbumArtView = self.albumViews.last as AlbumArtView
		//self.itemWidth = itemView.bounds.size.width
		
		if prevItemWidth > 0
		{
			self.scrollOffset = self.scrollOffset / prevItemWidth * self.itemWidth
		}
		else
		{
			
		}
		
	}
	
	func reloadData()
	{
		self.reloadDataAtStartIndex(0)
	}
	
	func loadViewAtIndex(index: Int)
	{
		let albumView = self.albumScrollDataSource?.viewForAlbumAtIndex(index)
		self.containerView?.addSubview(albumView!)
		
		albumView?.centerInSuperView()
		
		self.albumViews.append(albumView!)
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
	}*/
	
	var albumArtViews = [AlbumArtView]()
	var visiblePages = [AlbumArtView]()
	
	var songs = [Song]()
	{
		didSet
		{
			self.loadVisiblePages()
		}
	}
	
	required init(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		
		self.delegate = self
	}
	
	func createAlbumArt()
	{
		for song in self.songs
		{
			let albumArt = AlbumArtView(urlString: song.artwork!, frame: CGRect(x: 0, y: 0, width: Constants.ALBUM_ART_SIZE, height: Constants.ALBUM_ART_SIZE))
			
			self.albumArtViews.append(albumArt)
		}
		
		self.loadVisiblePages()
	}
	
	func loadPage(page: Int)
	{
		if page < 0 || page >= self.songs.count
		{
			// If it's outside the range of what you have to display, then do nothing
			return
		}
		
		/*if let pageView = self.visiblePages[page] as? AlbumArtView
		{
			// Do nothing. The view is already loaded.
		}
		else
		{*/
			var frame = self.bounds
			frame.origin.x = frame.size.width * CGFloat(page)
			frame.origin.y = 0.0
			
		//let newPageView = self.albumArtViews[page] as AlbumArtView
		//	newPageView.frame = frame
		//	self.addSubview(newPageView)
		
		let song = self.songs[page] as Song
		
			let albumArt = AlbumArtView(urlString: song.artwork!, frame: frame)
		
			self.addSubview(albumArt)
			
			self.albumArtViews.append(albumArt)
		//}
	}
	
	func purgePage(page: Int)
	{
		if page < 0 || page >= self.albumArtViews.count
		{
			// If it's outside the range of what you have to display, then do nothing
			return
		}
		
		// Remove a page from the scroll view and reset the container array
		//	if let pageView = self.visiblePages[page] as AlbumArtView
		//{
			let pageView = self.albumArtViews[page] as AlbumArtView
			pageView.removeFromSuperview()
			self.albumArtViews.removeAtIndex(page)
		//}
	}
	
	func loadVisiblePages()
	{
		// First, determine which page is currently visible
		let pageWidth = self.width
		
		let page = (self.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)
		
		// Update the page control
		
		// Figure out which pages to load
		let firstPage = page - 1
		let lastPage = page + 1
		
		// Purge anything before the first page
		for var index: CGFloat = 0; index < firstPage; ++index
		{
			purgePage(Int(index))
		}
		
		// Load pages in our range
		for var index = firstPage; index <= lastPage; ++index
		{
			loadPage(Int(index))
		}
		
		// Purge anything after the last page
		let total = self.albumArtViews.count
		for var index = lastPage+1; Int(index) < total; ++index
		{
			purgePage(Int(index))
		}
	}
	
	
	// MARK: UIScrollView Delegate Methods
	func scrollViewDidScroll(scrollView: UIScrollView)
	{
		self.loadVisiblePages()
	}
	
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
