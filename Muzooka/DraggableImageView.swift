//
//  DraggableImageView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/13/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

protocol DragDelegate
{
	func dragViewDragged(difference: CGFloat)
	
	func dragViewReset()
	
	func dragViewRequestedAdd()
	
	func dragViewRequestedPass()
}

class DraggableImageView: UIImageView
{
	var xFromCenter: CGFloat = 0
	var yFromCenter: CGFloat = 0
	var originalPoint: CGPoint = CGPoint.zeroPoint
	
	var dragDelegate: DragDelegate?
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		
		self.userInteractionEnabled = true
		
		let panRecognizer = UIPanGestureRecognizer(target: self, action: "handleDrag:")
		
		self.addGestureRecognizer(panRecognizer)
	}
	
	required init(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		
		let panRecognizer = UIPanGestureRecognizer(target: self, action: "handleDrag:")
		
		self.addGestureRecognizer(panRecognizer)
	}
	
	func handleDrag(gesture: UIPanGestureRecognizer)
	{
		self.xFromCenter = gesture.translationInView(self).x
		self.yFromCenter = gesture.translationInView(self).y
		
		switch(gesture.state)
		{
			case UIGestureRecognizerState.Began:
				self.originalPoint = self.center
				break
				
			case UIGestureRecognizerState.Changed:
				let rotationStrength: Float = Float(min(xFromCenter / Constants.ROTATION_STRENGTH, Constants.ROTATION_MAX))
				
				let rotationAngle = Constants.ROTATION_ANGLE * -rotationStrength
				
				let scale = max(1 - fabsf(rotationStrength) / Constants.SCALE_STRENGTH, Constants.SCALE_MAX)
				
				self.center = CGPoint(x:self.originalPoint.x + self.xFromCenter, y: self.originalPoint.y) //y: self.originalPoint.y + yFromCenter)
				
				let transform = CGAffineTransformMakeRotation(CGFloat(rotationAngle))
				
				let scaleTransform = CGAffineTransformScale(transform, CGFloat(scale), CGFloat(scale))
				
				self.transform = scaleTransform
				
				self.dragDelegate?.dragViewDragged(self.xFromCenter)
				
				break
				
			case UIGestureRecognizerState.Ended:
				self.reset()
				
				break
				
			default:
				break
		}
	}
	
	func reset()
	{
		if self.xFromCenter > Constants.ACTION_MARGIN
		{
			println("EXIT STAGE RIGHT")
			
			self.dragDelegate!.dragViewRequestedAdd()
			
			self.popToX(Constants.EXIT_MARGIN)
		}
		else if self.xFromCenter < -Constants.ACTION_MARGIN
		{
			println("EXIT STAGE LEFT")
			
			self.dragDelegate!.dragViewRequestedPass()
			
			self.popToX(-Constants.EXIT_MARGIN)
		}
		else
		{
			UIView.animateWithDuration(Constants.MEDIUM_ANIMATION_DURATION, animations:
				{ () -> Void in
					
					self.center = self.originalPoint
					self.transform = CGAffineTransformMakeRotation(0)
					
					//self.transform = CGAffineTransformIdentity
					
					self.dragDelegate?.dragViewReset()
				})
				{ (Bool) -> Void in
					
			}
		}
		
	}
	
	func popToX(xPos: CGFloat)
	{
		UIView.animateWithDuration(Constants.SHORT_ANIMATION_DURATION, delay: 0.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations:
			{ () -> Void in
				self.center = CGPoint(x: self.center.x + (xPos < 0 ? Constants.SMALL_GAP : -Constants.SMALL_GAP), y: self.center.y)
			}) { (Bool) -> Void in
				
				UIView.animateWithDuration(Constants.MEDIUM_ANIMATION_DURATION, delay: 0.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations:
					{ () -> Void in
						self.center = CGPoint(x: xPos, y: self.center.y)
					})
					{ (Bool) -> Void in
						self.transform = CGAffineTransformIdentity
						
						UIView.animateWithDuration(Constants.MEDIUM_ANIMATION_DURATION, delay: Constants.MEDIUM_ANIMATION_DURATION, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations:
							{ () -> Void in
								self.center = CGPoint(x:CGRectGetMidX(self.superview!.frame), y: self.center.y)
							},
							completion:
							{ (Bool) -> Void in
								
						})
				}
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
