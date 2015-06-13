//
//  LoginButton.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/28/15.
//  Copyright (c) 2015 com.muzooka. All rights reserved.
//

import UIKit

class LoginButton: UIButton
{
	@IBOutlet var heightConstraint: NSLayoutConstraint!
	
	var iconImageView: UIImageView?
	
	override var highlighted: Bool
	{
		didSet
		{
			self.setNeedsDisplay()
		}
		
	}
	
	override func awakeFromNib()
	{
		super.awakeFromNib()
		
		//self.layer.masksToBounds = true
		
		//var type = LoginButtonType(rawValue:self.tag)
		
		//self.setUpViewForButtonType(type!)
	}
	
	override func didMoveToWindow()
	{
		super.didMoveToWindow()
		
		var type = LoginButtonType(rawValue:self.tag)
		
		self.setUpViewForButtonType(type!)
	}
	
	func setUpViewForButtonType(type: LoginButtonType)
	{
		var imageIcon: UIImage = UIImage()
		
		switch type
		{
			case .Facebook:
				imageIcon = UIImage(named: Constants.IMAGE_FACEBOOK_ICON)!
				
				break
				
			case .Google:
				imageIcon = UIImage(named: Constants.IMAGE_GOOGLE_ICON)!
				
				break
				
			case .Email:
				imageIcon = UIImage(named: Constants.IMAGE_EMAIL_ICON)!
				
				break
		}
		
		self.iconImageView = UIImageView(image: imageIcon)
		
		self.iconImageView!.frame = CGRect(origin: CGPointZero, size: imageIcon.size)
		
		self.addSubview(self.iconImageView!)
		
		self.heightConstraint.constant = imageIcon.size.height
		
		self.setNeedsDisplay()
	}
	
	/*
	override func drawLayer(layer: CALayer!, inContext ctx: CGContext!)
	{
		super.drawLayer(layer, inContext: ctx)
		
		layer.cornerRadius = Constants.BUTTON_CORNER_RADIUS
		layer.borderColor = UIColor.whiteColor().CGColor
		layer.borderWidth = 2.0
	}*/
	
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect)
	{
		let context = UIGraphicsGetCurrentContext()
		
		var newFrame: CGRect
		
		if(self.iconImageView != nil)
		{
			let frame = CGRect(origin: rect.origin, size: CGSize(width: rect.size.width, height: self.iconImageView!.frame.height))
			newFrame = frame.rectByInsetting(dx: 2.0, dy: 2.0)
		}
		else
		{
			newFrame = rect.rectByInsetting(dx: 2.0, dy: 2.0)
		}
		
		let path = UIBezierPath(roundedRect: newFrame, cornerRadius: Constants.BUTTON_CORNER_RADIUS)
		
		var fillColor: UIColor
		
		if self.highlighted
		{
			fillColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
		}
		else
		{
			fillColor = UIColor.clearColor()
		}
		
		CGContextSaveGState(context)
		CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
		CGContextSetLineWidth(context, 2.0)
		CGContextSetFillColorWithColor(context, fillColor.CGColor)
		CGContextAddPath(context, path.CGPath)
		//CGContextStrokePath(context)
		CGContextDrawPath(context, kCGPathFillStroke)
		CGContextRestoreGState(context)
	}
}
