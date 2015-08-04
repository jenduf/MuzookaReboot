//
//  TagCollectionCell.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/2/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class TagCollectionCell: UICollectionViewCell
{
    @IBOutlet var tagText: UILabel!
    
    
    override var highlighted: Bool
    {
        didSet
        {
            if highlighted == true
            {
                self.layer.backgroundColor = Color.SearchTint.uiColor.CGColor
                self.layer.borderColor = Color.SearchTint.uiColor.CGColor
                self.tagText.textColor = UIColor.whiteColor()
            }
            else
            {
                self.layer.backgroundColor = UIColor.clearColor().CGColor
                self.layer.borderColor = Color.TagBorderColor.uiColor.CGColor
                self.tagText.textColor = Color.SearchHeaderTextColor.uiColor
            }
        }
    }
    
    override var selected: Bool
    {
        didSet
        {
            if selected == true
            {
                self.layer.backgroundColor = Color.SearchTint.uiColor.CGColor
                self.layer.borderColor = Color.SearchTint.uiColor.CGColor
                self.tagText.textColor = UIColor.whiteColor()
            }
            else
            {
                self.layer.backgroundColor = UIColor.clearColor().CGColor
                self.layer.borderColor = Color.TagBorderColor.uiColor.CGColor
                self.tagText.textColor = Color.SearchHeaderTextColor.uiColor
            }
        }
    }
    
    override func drawLayer(layer: CALayer!, inContext ctx: CGContext!)
    {
        self.layer.borderColor = Color.TagBorderColor.uiColor.CGColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = (self.height / 2)
    }
    
    override func drawRect(rect: CGRect)
    {
        
        
    }
    
}
