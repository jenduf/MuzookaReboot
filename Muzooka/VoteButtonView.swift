//
//  VoteButtonView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/16/15.
//  Copyright (c) 2015 com.muzooka. All rights reserved.
//

import UIKit

protocol VoteButtonViewDelegate
{
    func voteButtonSelected(voteButton: VoteButtonView)
}

class VoteButtonView: UIView
{
	var iconImageView: UIImageView?
    
    var delegate: VoteButtonViewDelegate?
	
	var isActive: Bool = false
	
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        let recognizer = UITapGestureRecognizer(target: self, action: "tapped:")
        self.addGestureRecognizer(recognizer)
    }
    
	required init(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		
		self.iconImageView = UIImageView(image: UIImage(named: Constants.IMAGE_HEART_EMPTY), highlightedImage: UIImage(named: Constants.IMAGE_HEART_FILLED))
		self.addSubview(self.iconImageView!)
		self.iconImageView?.centerInSuperView()
	}
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.iconImageView = UIImageView(image: UIImage(named: Constants.IMAGE_HEART_EMPTY), highlightedImage: UIImage(named: Constants.IMAGE_HEART_FILLED))
        self.addSubview(self.iconImageView!)
    }
	
	func setActive(active: Bool, animated: Bool = false)
	{
		self.isActive = active
		
		if animated
		{
			/*self.transform = CGAffineTransformMakeScale(0.5, 0.5)
			
			UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 4.0, options: UIViewAnimationOptions.AllowAnimatedContent, animations:
			{ () -> Void in
				//self.transform = CGAffineTransformMakeScale(1.2, 1.2)
				self.transform = CGAffineTransformIdentity
			},
			completion:
			{ (Bool) -> Void in
				self.iconImageView?.highlighted = self.isActive
					
					//UIView.animateWithDuration(Constants.SHORT_ANIMATION_DURATION, animations:
				//{ () -> Void in
				//	self.transform = CGAffineTransformIdentity
				//})
			})*/
			
			UIView.animateWithDuration(0.1, animations:
			{ () -> Void in
				self.transform = CGAffineTransformMakeScale(0.8, 0.8)
			},
			completion:
			{ (Bool) -> Void in
				UIView.animateWithDuration(0.1, animations:
				{ () -> Void in
					self.transform = CGAffineTransformMakeScale(1.2, 1.2)
				},
				completion:
				{ (Bool) -> Void in
					self.iconImageView?.highlighted = self.isActive
					
					UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 4.0, options: UIViewAnimationOptions.AllowAnimatedContent, animations:
					{ () -> Void in
							//self.transform = CGAffineTransformMakeScale(1.2, 1.2)
							self.transform = CGAffineTransformIdentity
					},
					completion:
					{ (Bool) -> Void in
						
					})
				})
			})
		}
		else
		{
			self.iconImageView?.highlighted = self.isActive
		}
		
		
		/*let animation = CABasicAnimation(keyPath: "path")
		animation.fromValue = 0.8
		animation.toValue = 1.2
		animation.duration = 1.0
		animation.fillMode = kCAFillModeForwards
		animation.removedOnCompletion = false
		animation.autoreverses = true
		self.layer.addAnimation(animation, forKey: nil)*/
	}
    
    func tapped(gesture: UITapGestureRecognizer)
    {
        self.setActive(!self.isActive, animated: true)
        
        self.delegate?.voteButtonSelected(self)
    }
	
	/*
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect)
	{
		let context = UIGraphicsGetCurrentContext()
		
		let circlePath = UIBezierPath(ovalInRect: rect.rectByInsetting(dx: Constants.CIRCLE_STROKE, dy: Constants.CIRCLE_STROKE)).CGPath
		
		var fillColor = UIColor.clearColor()
		var strokeColor = Color.FavoriteInactive.uiColor
		
		if self.isActive
		{
			fillColor = Color.FavoriteActive.uiColor
			strokeColor = UIColor.clearColor()
		}
		
		CGContextSaveGState(context)
		CGContextSetFillColorWithColor(context, fillColor.CGColor)
		CGContextSetStrokeColorWithColor(context, strokeColor.CGColor)
		CGContextSetLineWidth(context, Constants.CIRCLE_STROKE)
		CGContextAddPath(context, circlePath)
		CGContextDrawPath(context, kCGPathFillStroke)
		CGContextRestoreGState(context)
		
		
	}*/


}
