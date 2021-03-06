//
//  SegmentView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/4/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class SegmentView: UIView
{
	var segments = [BorderedButton]()
	var indicatorView: IndicatorView?

	var delegate: SegmentViewDelegate?
    
    var selectedIndex: Int = 0
	
	var segmentStrings: String?
	{
		didSet
		{
			let segArray = segmentStrings?.componentsSeparatedByString(",")
			self.updateSegments(segArray!)
		}
	}

	func updateSegments(segmentTitles: [String])
	{
		// remove old views
		for btn in self.segments
		{
			btn.removeFromSuperview()
		}
		
		self.segments.removeAll()
		
		let width = UIScreen.mainScreen().bounds.width
			
		let segWidth = Int(width / CGFloat(segmentTitles.count))
		
		let indicatorFrame = CGRect(x: 0, y: self.frame.height - Constants.INDICATOR_HEIGHT, width: CGFloat(segWidth), height: Constants.INDICATOR_HEIGHT)
		
		//	let buttonFrame = CGRect(x: 0, y: 0, width: segWidth, height: Int(self.frame.height - indicatorView!.frame.height))
		
		//println("self frame: \(self.frame) indicatorFrame: \(indicatorFrame) bounds: \(self.bounds)")
		
		// update indicator
		if self.indicatorView == nil
		{
			self.indicatorView = IndicatorView(frame: indicatorFrame)
			self.indicatorView!.percent = 1.0
			self.addSubview(self.indicatorView!)
		}
		else
		{
			self.indicatorView?.frame = indicatorFrame
		}
		
		// update segments
		var nextX = 0
		var index = 0
		
		for item in segmentTitles
		{
			var btn = BorderedButton(frame: CGRect(x: nextX, y: 0, width: segWidth, height: Int(self.frame.height - indicatorView!.frame.height)), text: item, stroke: UIColor.clearColor(), fontSize: Constants.FONT_SIZE_SEGMENT)
			btn.tag = index
			btn.addTarget(self, action: "segmentClicked:", forControlEvents: UIControlEvents.TouchUpInside)
			btn.setTitleColor(Color.White.uiColor.colorWithAlphaComponent(0.5), forState: UIControlState.Normal)
			btn.setTitleColor(Color.White.uiColor, forState: UIControlState.Selected)
			
			if index == 0
			{
				btn.selected = true
			}
			
			self.addSubview(btn)
			
			self.segments.append(btn)
			
			nextX += Int(btn.frame.width)
			index++
		}
	}
	
	
	@IBAction func segmentClicked(btn: BorderedButton)
	{
        self.selectedIndex = btn.tag
        
		for b in self.segments
		{
			b.selected = false
		}
		
		btn.selected = true
		
		UIView.animateWithDuration(0.5, animations:
		{ () -> Void in
			self.indicatorView!.center.x = btn.center.x
		})
		
		self.delegate?.segmentViewDidSelectViewIndex(self, index: btn.tag)
	}

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
