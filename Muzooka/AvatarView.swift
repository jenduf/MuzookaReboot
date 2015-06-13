//
//  AvatarView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/6/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

@IBDesignable
class AvatarView: UIView
{
	var avatarDelegate: AvatarDelegate!
	
	let backgroundLayer = CAShapeLayer()
	
	let imageLayer = CALayer()
	
	@IBInspectable var showDetails = false
	
	var fillColor: UIColor = UIColor.clearColor()
	{
		didSet
		{
			self.updateLayerProperties()
		}
	}

	var image: UIImage?
	{
		didSet
		{
			self.updateLayerProperties()
		}
	}
	
	let nameLabel: UILabel =
	{
		let label = UILabel()
		label.font = UIFont(name: Constants.FONT_PROXIMA_NOVA_SEMIBOLD, size: Constants.FONT_SIZE_AVATAR)
		label.textAlignment = .Center
		label.textColor = Color.TextDark.uiColor
		
		return label
	}()
	
	let scoreLabel: UILabel =
	{
		let label = UILabel()
		label.font = UIFont(name: Constants.FONT_PROXIMA_NOVA_REGULAR, size: Constants.FONT_SIZE_AVATAR)
		label.textAlignment = .Center
		label.textColor = UIColor.whiteColor()
		label.layer.masksToBounds = true
		
		return label
	}()
	
	var user: User?
	{
		didSet
		{
			self.nameLabel.text = user?.name
			
			self.scoreLabel.text = "\(user!.scoreDetails.score)"
			
			self.scoreLabel.backgroundColor = Utils.UIColorFromRGB(user!.scoreDetails.colorCode, alpha: 1.0)
			
			if !user!.avatarURL!.isEmpty
			{
				self.image = UIImage.new()
				
				self.image!.loadFromURL(NSURL(string: user!.avatarURL!)!, callback:
				{ (image) -> Void in
					self.image = image
				})
			}
			
			//self.image = user?.image
		}
	}
	
	override func awakeFromNib()
	{
		super.awakeFromNib()
	}
	
	override func didMoveToWindow()
	{
		super.didMoveToWindow()
		
		self.layer.addSublayer(self.backgroundLayer)
		
		self.layer.addSublayer(self.imageLayer)
		
		if self.showDetails == true
		{
			self.addSubview(self.nameLabel)
		}
		
		self.addSubview(self.scoreLabel)
		
		self.updateLayerProperties()
	}
	
	override func layoutSubviews()
	{
		super.layoutSubviews()
		
		self.layoutBackgroundLayer()
		
		self.layoutImageLayer()
		
		let referenceRatio = self.frame.size.height / Constants.AVATAR_MAX_SIZE
		
		let labelHeight = Constants.LABEL_HEIGHT * referenceRatio
		
		// size the label
		self.nameLabel.frame = CGRect(x: 0.0, y: self.bounds.size.height + Constants.PADDING, width: self.bounds.size.width, height: labelHeight)
		
		let fontSize = Constants.FONT_SIZE_AVATAR * referenceRatio
		
		self.nameLabel.font = UIFont(name: Constants.FONT_PROXIMA_NOVA_SEMIBOLD, size: fontSize)
		
		let scoreSize = self.frame.height * 0.3
		
		let scoreRect = CGRect(x: self.frame.width - scoreSize, y: self.frame.height - scoreSize, width: scoreSize, height: scoreSize)
		
		self.scoreLabel.frame = scoreRect
		
		self.scoreLabel.layer.cornerRadius = scoreRect.height / 2.0
		
		self.scoreLabel.font = UIFont(name: Constants.FONT_PROXIMA_NOVA_REGULAR, size: fontSize)
		
		/*self.backgroundLayer.path = UIBezierPath(ovalInRect: self.bounds).CGPath
		
		if(self.image != nil)
		{
			// size the avatar image to fit
			self.photoLayer.frame = CGRect(x: (self.bounds.size.width - self.image.size.width + Constants.AVATAR_LINE_WIDTH) / 2, y: (self.bounds.size.height - self.image.size.height - Constants.AVATAR_LINE_WIDTH) / 2, width: self.image.size.width, height: self.image.size.height)
		}
		
		// draw the circle
		self.circleLayer.path = UIBezierPath(ovalInRect: self.bounds).CGPath
		self.circleLayer.strokeColor = UIColor.whiteColor().CGColor
		self.circleLayer.lineWidth = Constants.AVATAR_LINE_WIDTH
		self.circleLayer.fillColor = UIColor.clearColor().CGColor
		
		// size the layer
		self.maskLayer.path = self.circleLayer.path
		self.maskLayer.position = CGPoint(x: 0.0, y: 10.0)
		*/
	}
	
	func layoutBackgroundLayer()
	{
		let rect = CGRectInset(self.bounds, Constants.AVATAR_LINE_WIDTH / 2.0, Constants.AVATAR_LINE_WIDTH / 2.0)
		let path = UIBezierPath(ovalInRect: rect)
			
		self.backgroundLayer.path = path.CGPath
		self.backgroundLayer.fillColor = self.fillColor.CGColor
		self.backgroundLayer.lineWidth = 0//Constants.AVATAR_LINE_WIDTH
		self.backgroundLayer.strokeColor = UIColor(white: 0.5, alpha: 0.3).CGColor
	}
	
	func layoutImageLayer()
	{
		let maskLayer = CAShapeLayer()
		let dx = Constants.AVATAR_LINE_WIDTH + 3.0
		let insetBounds = CGRectInset(self.layer.bounds, dx, dx)
		let innerPath = UIBezierPath(ovalInRect: self.bounds)//insetBounds)
		maskLayer.path = innerPath.CGPath
		maskLayer.fillColor = UIColor.blackColor().CGColor
		maskLayer.frame = self.layer.bounds
			
		self.imageLayer.mask = maskLayer
		self.imageLayer.contentsGravity = kCAGravityResizeAspectFill
		self.imageLayer.frame = self.layer.bounds
	}
	
	func updateLayerProperties()
	{
		self.backgroundLayer.fillColor = self.fillColor.CGColor
		
		if self.image == nil
		{
			self.imageLayer.contents = UIImage(named: Constants.IMAGE_DEFAULT_ART)?.CGImage
		}
		else
		{
			self.imageLayer.contents = self.image!.CGImage
		}
	}
	
	/*
	override func drawLayer(layer: CALayer!, inContext ctx: CGContext!)
	{
		layer.cornerRadius = self.frame.height / 2
		layer.masksToBounds = true
	}

	
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect)
	{
        // Drawing code
	}
	*/

}
