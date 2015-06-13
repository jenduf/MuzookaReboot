//
//  MuzookaViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class MuzookaViewController: UIViewController, APIDelegate
{
	
	var navController: MuzookaNavController?
	{
		didSet
		{
			
		}
	}

	override func viewDidLoad()
	{
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// override for updating view when segment is selected
	func setSelectedIndex(index: Int)
	{
		
	}
	
	// override
	func loadData()
	{
		self.navController!.showLoader(true)
	}
	
	func performButtonActionType(type: NavButtonType)
	{
		// override
	}

	
    // MARK: - Navigation Delegate Methods

    // In a storyboard-based application, you will often want to do a little preparation before navigation
	override func didMoveToParentViewController(parent: UIViewController?)
	{
		super.didMoveToParentViewController(parent)
		
		self.navController = parent as? MuzookaNavController
	}
	
	override func willMoveToParentViewController(parent: UIViewController?)
	{
		super.willMoveToParentViewController(parent)
		
		self.navController = parent as? MuzookaNavController
	}
	
	// MARK: API Delegate Methods
	func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject)
	{
		// hide loader
		self.navController!.showLoader(false)
	}
	
	func apiManagerDidReturnError(apiManager: APIManager, error: String)
	{
		// hide loader
		self.navController!.showLoader(false)
	}
	
	func apiManagerDidReturnNeedsAuthenticatedUser(apiManager: APIManager)
	{
		// hide loader
		self.navController!.showLoader(false)
		
		self.navController?.showLoginScreen()
	}

}
