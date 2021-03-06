//
//  MenuCell.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell
{
	@IBOutlet var menuTitle: UILabel!
	@IBOutlet var menuImage: UIImageView!
	
	var active: Bool = false
	{
		didSet
		{
			self.menuImage.highlighted = active
			
			self.menuTitle.textColor = (active ? Color.MenuActive.uiColor : Color.MenuInactive.uiColor)
		}
	}

	override func awakeFromNib()
	{
		super.awakeFromNib()
		
		self.preservesSuperviewLayoutMargins = false

		self.layoutMargins = UIEdgeInsetsZero
	}

	override func setSelected(selected: Bool, animated: Bool)
	{
		super.setSelected(selected, animated: animated)
	}

}
