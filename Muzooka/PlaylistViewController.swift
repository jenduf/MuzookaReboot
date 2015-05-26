//
//  PlaylistViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class PlaylistViewController: MuzookaViewController
{

	override func viewDidLoad()
	{
		super.viewDidLoad()

		if User.currentUser != nil
		{
			APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.PersonalPlaylists, delegate: self, parameters: nil, appendedString: "\(User.currentUser.userID)")
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject)
	{
		super.apiManagerDidReturnData(apiManager, data: data)
		
	}

}
