
//
//  MuzookaCellDelegate.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/17/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation

protocol MuzookaCellDelegate
{
	func cellRequestedAction(cell: UITableViewCell, item: AnyObject)
	
	func cellRequestedShowMenu(cell: UITableViewCell, item: AnyObject)
}