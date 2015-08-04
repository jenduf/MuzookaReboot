//
//  GraphLineView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/30/15.
//  Copyright (c) 2015 com.muzooka. All rights reserved.
//

import UIKit

class GraphLineView: UIView
{
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
        CGContextSetStrokeColorWithColor(context, Color.GraphLine.uiColor.CGColor)
        CGContextSetLineWidth(context, 2.0)
        CGContextSetLineDash(context, 0.0, [4, 2], 2)
        CGContextMoveToPoint(context, 0, 0)
        CGContextAddLineToPoint(context, rect.maxX, rect.maxY)
        CGContextStrokePath(context)
        CGContextRestoreGState(context)
    }
}
