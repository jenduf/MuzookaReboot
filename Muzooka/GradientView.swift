//
//  GradientView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/29/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class GradientView: UIView
{
	
	let gradientLayer = CAGradientLayer()
	
	var colors: [CGColor]?
	{
		didSet
		{
			self.gradientLayer.colors = colors
		}
	}
	
	override func didMoveToWindow()
	{
		super.didMoveToWindow()
		
		self.layer.addSublayer(self.gradientLayer)
	}
	
	override func layoutSubviews()
	{
		super.layoutSubviews()
		
		self.layoutGradientLayer()
		
		self.layer.cornerRadius = 2.0
		self.layer.masksToBounds = true
	}
	
	
	func layoutGradientLayer()
	{
		self.gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
		self.gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
		//self.gradientLayer.locations = [0.0, 1.0]
		self.gradientLayer.frame = CGRect(origin: CGPoint.zeroPoint, size: self.frame.size)
	}
	
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
