//
//  FirstStepView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/13/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class FirstStepView: UIView
{
	var stepLabel: UILabel
	var buttonRegister: BorderedButton?
	var buttonDismiss: BorderedButton?
	
	var step: TutorialSteps?
	{
		didSet
		{
			//self.stepLabel.text = step!.stepText
			
			
			var style = NSMutableParagraphStyle()
			style.lineSpacing = Constants.LINE_SPACING
			
			var attributes = [ NSParagraphStyleAttributeName : style ]
			
			var attrString = NSMutableAttributedString(string: step!.stepText, attributes: attributes)
			self.stepLabel.attributedText = attrString
			
			switch(step!)
			{
				case .Four:
					var logoImage = UIImageView(image: UIImage(named: "login_muzooka_logo"))
					self.addSubview(logoImage)
					
					logoImage.frame.origin = CGPoint(x: self.stepLabel.frame.origin.x, y: self.stepLabel.frame.minY - Constants.LABEL_HEIGHT)
					
					self.buttonDismiss = BorderedButton(frame: CGRect(x: Constants.BUTTON_PADDING, y: self.frame.maxY - Constants.BUTTON_HEIGHT, width: self.frame.size.width - (Constants.BUTTON_PADDING * 2), height: Constants.BUTTON_HEIGHT), text: Constants.TITLE_NO_THANKS, stroke: UIColor.clearColor(), fontSize: Constants.FONT_SIZE_STEP_BUTTON)
					//self.buttonDismiss!.tag = Constants.TAG_DISMISS
					self.buttonDismiss?.contentEdgeInsets = UIEdgeInsets(top: Constants.PADDING, left: Constants.PADDING, bottom: Constants.PADDING, right: Constants.PADDING)
					self.addSubview(self.buttonDismiss!)
					
					self.buttonRegister = BorderedButton(frame: CGRect(x: Constants.BUTTON_PADDING, y: self.buttonDismiss!.frame.minY - Constants.BUTTON_HEIGHT - Constants.PADDING, width: self.frame.size.width - (Constants.BUTTON_PADDING * 2), height: Constants.BUTTON_HEIGHT), text: Constants.TITLE_REGISTER, stroke: UIColor.whiteColor(), fontSize: Constants.FONT_SIZE_STEP_BUTTON)
					self.buttonRegister!.tag = Constants.TAG_ACTION
					self.addSubview(self.buttonRegister!)
					
					break
				
				default:
					
					break
			}
		}
	}
	
	required init(coder aDecoder: NSCoder)
	{
		self.stepLabel = UILabel.new()
		
		super.init(coder: aDecoder)
	}
	
	override init(frame: CGRect)
	{
		self.stepLabel = UILabel(frame: CGRect(x: Constants.BUTTON_PADDING, y: (frame.midY - (Constants.STEP_LABEL_HEIGHT / 2)), width: (frame.size.width - (Constants.BUTTON_PADDING * 2)), height: Constants.STEP_LABEL_HEIGHT))
		self.stepLabel.textColor = UIColor.whiteColor()
		self.stepLabel.font = UIFont(name: Constants.FONT_PROXIMA_NOVA_THIN, size: Constants.FONT_SIZE_STEP)
		self.stepLabel.textAlignment = NSTextAlignment.Left
		self.stepLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
		self.stepLabel.numberOfLines = 0
	
		super.init(frame: frame)
		
		self.addSubview(self.stepLabel)
	}
	

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
