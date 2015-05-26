//
//  ProfileViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/6/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class ProfileViewController: MuzookaViewController
{
	@IBOutlet var avatarView: AvatarView!
	@IBOutlet var backgroundImageView: UIImageView!

	override func loadData()
	{
		super.loadData()
		
		APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.UserDetails, delegate: self, parameters: nil, appendedString: "\(User.currentUser.userID)")
	}

	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		// blur background image
		var darkBlur = UIBlurEffect(style: .Dark)
		
		var blurView = UIVisualEffectView(effect: darkBlur)
		blurView.frame = self.backgroundImageView.frame
		self.backgroundImageView.addSubview(blurView)
		
		if User.currentUser != nil
		{
			self.avatarView.user = User.currentUser
			
			self.backgroundImageView.image = User.currentUser.image
		}
	}
	
	@IBAction func editProfile(sender: AnyObject)
	{
		self.navController!.navigateToControllerWithIdentifier(Constants.EDIT_PROFILE_VIEW_CONTROLLER)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject)
	{
		super.apiManagerDidReturnData(apiManager, data: data)
		
		switch apiManager.apiRequest!
		{
			case .UserDetails:
			
				break
			
			default:
			
				break
		}
		
		
	}

}
