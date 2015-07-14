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
	@IBOutlet var tagView: TagView!
	
	var tagInfo: TagInfo?
	{
		didSet
		{
			self.tagView.tagString = tagInfo!.name
		}
	}
    
}
