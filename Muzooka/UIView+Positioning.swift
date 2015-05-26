//
//  UIView+Positioning.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/14/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit
import Foundation

extension UIView
{
	// global positioning
	func centerInRect(rect: CGRect)
	{
		self.center = CGPoint(x: rect.midX, y: rect.midY)
	}
	
	func centerInSuperView()
	{
		self.centerInRect(self.superview!.bounds)
	}
	
	
	// vertical positioning
	func centerVerticallyInRect(rect: CGRect)
	{
		self.center = CGPoint(x: self.center.x, y: rect.midY)
	}
	
	func centerVerticallyInSuperView()
	{
		self.centerVerticallyInRect(self.superview!.bounds)
	}
	
	func centerVerticallyToTheRightOf(view: UIView, padding: CGFloat = 0)
	{
		self.center = CGPoint(x: padding + view.frame.maxX + (self.frame.width / 2), y: view.center.y)
	}
	
	func centerVerticallyToTheLeftOf(view: UIView, padding: CGFloat = 0)
	{
		self.center = CGPoint(x: view.frame.minX - (self.frame.width / 2) - padding, y: view.center.y)
	}
	
	
	// horizontal positioning
	func centerHorizontallyInRect(rect: CGRect)
	{
		self.center = CGPoint(x: rect.midX, y: self.center.y)
	}
	
	func centerHorizontallyInSuperView()
	{
		self.centerHorizontallyInRect(self.superview!.bounds)
	}
	
	func centerHorizontallyAbove(view: UIView, padding: CGFloat = 0)
	{
		self.center = CGPoint(x: view.center.x, y: view.frame.minY - (self.frame.height / 2) - padding)
	}
	
	func centerHorizontallyBelow(view: UIView, padding: CGFloat = 0)
	{
		self.center = CGPoint(x: view.center.x, y: padding + view.frame.maxY + (self.frame.height / 2))
	}
	
}