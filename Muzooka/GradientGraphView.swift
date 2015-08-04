//
//  GraphView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/19/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

@IBDesignable class GradientGraphView: UIView
{
	// gradient properties
	@IBInspectable var startColor: UIColor = UIColor.redColor()
	@IBInspectable var endColor: UIColor = UIColor.greenColor()
	
	var graphPoints = [Int]()
	{
		didSet
		{
			self.setNeedsDisplay()
		}
		
	}
	
	
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect)
	{
		// set up background clipping area
		var path = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSize(width: 8.0, height: 8.0))
		path.addClip()
		
		let context = UIGraphicsGetCurrentContext()
		let colors = [startColor.CGColor, endColor.CGColor]
		
		// set up color space
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		
		// set up color stops
		let colorLocations: [CGFloat] = [0.0, 1.0]
		
		// create gradient
		let gradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)
		
		// draw the gradient
		var startPoint = CGPoint.zeroPoint
		var endPoint = CGPoint(x: 0, y: self.bounds.height)
		
		CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
		
		
		if self.graphPoints.count > 0
		{
			// calculate the x point
			let margin: CGFloat = 20.0
			var columnXPoint =
			{
				(column: Int) -> CGFloat in
				
				// calculate gap between points
				let spacer = (rect.width - margin * 2 - 4) / CGFloat((self.graphPoints.count - 1))
				var x: CGFloat = CGFloat(column) * spacer
				x += margin + 2
				
				return x
			}
			
			// calculate the y point
			let topBorder: CGFloat = 60
			let bottomBorder: CGFloat = 50
			let graphHeight = rect.height - topBorder - bottomBorder
			let maxValue = maxElement(self.graphPoints)
			var columnYPoint =
			{
				(graphPoint: Int) -> CGFloat in
				
				var y: CGFloat = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
				y = graphHeight + topBorder - y // FLIP
				
				return y
			}
			
			// draw the line graph
			UIColor.whiteColor().setFill()
			UIColor.whiteColor().setStroke()
			
			// set up the points line
			var graphPath = UIBezierPath()
			
			// go to start of line
			graphPath.moveToPoint(CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
			
			// add points for each item in the graphPoints array at the correct (x, y) for the point
			for i in 1..<graphPoints.count
			{
				let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
				graphPath.addLineToPoint(nextPoint)
			}
			
			//graphPath.stroke()
			
			CGContextSaveGState(context)
			
			// make a copy of the path
			var clippingPath = graphPath.copy() as! UIBezierPath
			
			// add lines to the copied path to complete the clip area
			clippingPath.addLineToPoint(CGPoint(x: columnXPoint(graphPoints.count - 1), y: rect.height))
			clippingPath.addLineToPoint(CGPoint(x:columnXPoint(0), y: rect.height))
			clippingPath.closePath()
			
			// add the clipping path to the context
			clippingPath.addClip()
			
			let highestYPoint = columnYPoint(maxValue)
			startPoint = CGPoint(x: margin, y: highestYPoint)
			endPoint = CGPoint(x: margin, y: self.bounds.height)
			
			CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
			
			CGContextRestoreGState(context)
			
			// draw the line on top of the clipped gradient
			graphPath.lineWidth = 2.0
			graphPath.stroke()
			
			// draw graph circles
			for i in 0..<graphPoints.count
			{
				var point = CGPoint(x:columnXPoint(i), y: columnYPoint(graphPoints[i]))
				point.x -= 5.0/2
				point.y -= 5.0/2
				
				let circle = UIBezierPath(ovalInRect: CGRect(origin: point, size: CGSize(width: 5.0, height: 5.0)))
				circle.fill()
			}
			
			// draw horizontal graph lines on the top
			var linePath = UIBezierPath()
			
			// top line
			linePath.moveToPoint(CGPoint(x: margin, y: topBorder))
			linePath.addLineToPoint(CGPoint(x: rect.width - margin, y: topBorder))
			
			// center line
			linePath.moveToPoint(CGPoint(x: margin, y: graphHeight / 2 + topBorder))
			linePath.addLineToPoint(CGPoint(x: rect.width - margin, y: graphHeight / 2 + topBorder))
			
			// bottom line
			linePath.moveToPoint(CGPoint(x: margin, y: rect.height - bottomBorder))
			linePath.addLineToPoint(CGPoint(x: rect.width - margin, y: rect.height - bottomBorder))
			
			let color = UIColor(white: 1.0, alpha: 0.3)
			color.setStroke()
			
			linePath.lineWidth = 1.0
			linePath.stroke()
			
			
		}
	}
	

}
