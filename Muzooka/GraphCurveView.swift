//
//  GraphCurveView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/30/15.
//  Copyright (c) 2015 com.muzooka. All rights reserved.
//

import UIKit

class GraphCurveView: UIView
{
    var points:[Int]?
    var increment: Int = 0
    
    func setPointsAndIncrement(points: [Int], increment: Int)
    {
        self.points = points
        self.increment = increment
        
        self.setNeedsDisplay()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSaveGState(context)
        CGContextSetStrokeColorWithColor(context, Color.GraphCurveBorder.uiColor.CGColor)
        CGContextSetFillColorWithColor(context, Color.GraphCurveBorder.uiColor.colorWithAlphaComponent(0.5).CGColor)
        
        let lastPoint = (self.points!.last! / self.increment) * Int(Constants.GRAPH_PADDING)
        
        
        CGContextMoveToPoint(context, rect.size.width, CGFloat(lastPoint))
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height)
        CGContextAddLineToPoint(context, 0, rect.size.height)
        
        let point = self.points!.first!
        CGContextAddLineToPoint(context, 0, (CGFloat(point / self.increment) * Constants.GRAPH_PADDING))
        
        var lastY = (self.points![0] as Int / self.increment) * Int(Constants.GRAPH_PADDING)
        
        var lastP = point
        
        self.points?.removeAtIndex(0)
        
        var nextX = Constants.GRAPH_PADDING + Constants.PADDING + Constants.GRAPH_OFFSET
        
        var lastX = 0
        
        for p in self.points!
        {
            var nextY = CGFloat((p / self.increment) * Int(Constants.GRAPH_PADDING))
            var controlP1 = CGPoint(x:nextX - Constants.SIDE_PADDING, y:nextY + Constants.GRAPH_LINE_SIZE)
            var controlP2 = CGPoint(x:nextX - Constants.PADDING, y:nextY)
            if lastP > p
            {
                controlP1 = CGPoint(x: nextX - Constants.SIDE_PADDING, y: CGFloat(lastY))
                controlP2 = CGPoint(x: nextX - Constants.PADDING, y: nextY)
            }
            else if lastP < p
            {
                controlP1 = CGPoint(x: CGFloat(lastX), y: CGFloat(lastY))
                controlP2 = CGPoint(x: nextX - Constants.GRAPH_OFFSET, y:nextY)
            }
            
            CGContextAddCurveToPoint(context, controlP1.x, controlP1.y, controlP2.x, controlP2.y, nextX, CGFloat(nextY))
            
            println("p: \(p) nextX: \(nextX) nextY: \(nextY) controlP1: \(controlP1) controlP2: \(controlP2)")
            
            lastY = Int(nextY)
            
            lastX = Int(nextX)
            
            lastP = p
            
            nextX += (Constants.GRAPH_PADDING + Constants.PADDING + Constants.GRAPH_OFFSET)
        }
        
      //  CGContextAddCurveToPoint(context, 190, 210, 200, 70, 303, 125)
       // CGContextAddQuadCurveToPoint(context, 340, 150, 350, 150)
        //CGContextAddQuadCurveToPoint(context, 380, 155, 410, 145)
        //CGContextAddCurveToPoint(context, 500, 100, 540, 190, 580, 165)
        //CGContextAddLineToPoint(context, 580, rect.size.width)
        //CGContextAddLineToPoint(context, -5, rect.size.width)
        CGContextDrawPath(context, kCGPathFillStroke)
        CGContextRestoreGState(context)
        
    }
    
}
