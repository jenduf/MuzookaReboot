//
//  GraphView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/30/15.
//  Copyright (c) 2015 com.muzooka. All rights reserved.
//

import UIKit

class GraphView: UIView
{
    var rankLabelValues = [Int]()
    
    var weekdayValues = [String]()
    
    var graphHeight: CGFloat = 0.0
    var graphWidth: CGFloat = 0.0
    
    var increment: Int = 0
    
    var song: Song?
    {
        didSet
        {
            self.increment = Int(floorf(Float(song!.hotChartMax - song!.hotChartMin) / Constants.RANK_LABELS_COUNT))
            
            if increment > 0
            {
                var tempValues = [Int]()
                
                for var startIndex = song!.hotChartMax; startIndex > 0; startIndex -= increment
                {
                    tempValues.append(startIndex)
                }
                
                self.rankLabelValues.extend(tempValues.reverse())
                
                self.createRankLabels()
            }
        }
        
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
    }
    
    func createRankLabels()
    {
        var nextY: CGFloat = Constants.GRAPH_LINE_SIZE
        
        for rankValue in self.rankLabelValues
        {
            let label = UILabel(frame: CGRect(x: 0, y: nextY, width: 0, height: 0))
            label.textAlignment = NSTextAlignment.Center
            label.text = "\(rankValue)"
            label.textColor = UIColor.grayColor()
            self.addSubview(label)
            label.sizeToFit()
            
            label.centerHorizontallyInRect(CGRect(x: 0, y: label.top, width: Constants.GRAPH_PADDING, height: label.height))
            
            nextY += (label.height + Constants.SIDE_PADDING)
        }
        
        self.graphHeight = (nextY - Constants.SIDE_PADDING)
        
        self.createDayLabels()
    }
    
    func createDayLabels()
    {
        // get days of the week ordered by current day
        let calendar = NSCalendar.currentCalendar()
        var day = calendar.component(.CalendarUnitWeekday, fromDate: NSDate())
        
        let weekdays = NSCalendar.currentCalendar().veryShortWeekdaySymbols
        
        let total = weekdays.count
        
        for var index = 0; index < total; index++
        {
            self.weekdayValues.append(weekdays[(day - 1)] as! String)
            
            if day == total
            {
                day = 1
            }
            else
            {
                day++
            }
        }
        
        var nextX: CGFloat = Constants.GRAPH_PADDING + Constants.GRAPH_OFFSET
        
        for dayValue in self.weekdayValues
        {
            let label = UILabel(frame: CGRect(x: nextX, y: self.graphHeight + Constants.PADDING, width: 0, height: 0))
            label.textAlignment = NSTextAlignment.Center
            label.text = "\(dayValue)"
            label.textColor = UIColor.grayColor()
            self.addSubview(label)
            label.sizeToFit()
            
            nextX += (label.width + Constants.GRAPH_PADDING)
        }
        
        self.graphWidth = (nextX - Constants.GRAPH_PADDING)
        
        self.createGraph()
    }
    
    func createGraph()
    {
        let graphLeft = (Constants.GRAPH_PADDING + Constants.PADDING)
        
        let yLineView = UIView(frame: CGRect(x: graphLeft, y: 0, width: Constants.GRAPH_LINE_SIZE, height: self.graphHeight))
        yLineView.backgroundColor = Color.GraphBorder.uiColor
        
        self.addSubview(yLineView)
        
        let xLineView = UIView(frame: CGRect(x: (yLineView.right - Constants.PADDING), y: self.graphHeight - Constants.PADDING, width: (self.graphWidth - Constants.SIDE_PADDING), height: Constants.GRAPH_LINE_SIZE))
        xLineView.backgroundColor = Color.GraphBorder.uiColor
        
        self.addSubview(xLineView)
        
        let total = (self.rankLabelValues.count - 1)
        
        var nextY = Constants.PADDING + Constants.GRAPH_LINE_SIZE
        
        for var index = 0; index < total; index++
        {
            let graphLineView = GraphLineView(frame: CGRect(x: graphLeft + Constants.GRAPH_LINE_SIZE, y: nextY, width: (self.graphWidth - Constants.SIDE_PADDING - Constants.PADDING), height: 1))
            
            self.addSubview(graphLineView)
            
            nextY += (Constants.GRAPH_PADDING)
        }
        
        let curveView = GraphCurveView(frame: CGRect(x: graphLeft + Constants.GRAPH_LINE_SIZE, y: 0, width: (self.graphWidth - Constants.SIDE_PADDING - Constants.GRAPH_OFFSET - (Constants.GRAPH_LINE_SIZE * 2)), height: self.graphHeight - Constants.PADDING))
        
        var points = [Int]()
        
        for rank in self.song!.hotChartDays
        {
            let pointX = rank as Int //- self.song!.hotChartMin
            points.append(pointX)
        }
        
        curveView.setPointsAndIncrement(points, increment: self.increment)
        
        self.addSubview(curveView)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
