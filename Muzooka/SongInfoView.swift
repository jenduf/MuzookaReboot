//
//  SongInfoView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/30/15.
//  Copyright (c) 2015 com.muzooka. All rights reserved.
//

import UIKit

class SongInfoView: UIView
{
    @IBOutlet var playsLabel: UILabel!
    
    @IBOutlet var currentPosition: UILabel!
    @IBOutlet var trend: UILabel!
    
    @IBOutlet var graphView: GraphView!
    
    var song: Song?
    {
        didSet
        {
            self.playsLabel.text = "\(self.song!.listens!) plays - Uploaded \(self.song!.age!)"
            
            self.currentPosition.text = "\(self.song!.hotChartRank)"
            
            var signString: String = ""
            
            if self.song!.hotChartChange < 0
            {
                self.trend.textColor = Color.TrendingDownRed.uiColor
            }
            else
            {
                self.trend.textColor = Color.TrendingUpGreen.uiColor
                signString = "+"
            }
            
            self.trend.text = "\(signString)\(self.song!.hotChartChange)"
            
            self.graphView.song = self.song
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
