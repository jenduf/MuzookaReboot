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
	var itemSelected: Shareable?
	
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
	
	// MARK: Display Modal Views / Toggle Menus
	func showActionMenuWithTitle(title: String)
	{
		let alertController = UIAlertController(title: "\(title)", message: "", preferredStyle: .ActionSheet)
		
		let cancelAction = UIAlertAction(title: Constants.TITLE_CANCEL, style: .Cancel)
			{ (action) -> Void in
				//
		}
		
		alertController.addAction(cancelAction)
		
		let menuItems = self.itemSelected!.getActionItems() as [MenuAction]
		
		for item in menuItems
		{
			var alertAction = UIAlertAction(title: item.title, style: .Default, handler:
			{ (action) -> Void in
					self.performActionForItem(item)
			})
			
			alertController.addAction(alertAction)
		}
		
		self.presentViewController(alertController, animated: true)
		{ () -> Void in
				//
		}
	}
	
	func performActionForItem(menuItem: MenuAction)
	{
		switch menuItem
		{
			case .PlayLater:
				println("play later")
				let song = self.itemSelected as! Song
				MusicPlayer.sharedPlayer.addSongToPersonalQueue(song, playNow: false)
				break
				
			case .SongInfo:
				let sivc = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.SONG_INFO_VIEW_CONTROLLER) as! SongInfoViewController
				sivc.songID = "\(self.itemSelected!.getItemID())"//"\(song.songID)"
				
				self.navController?.navigateToController(sivc)
				//let song = self.itemSelected as! Song
				
				break
				
			case .ArtistInfo, .ViewProfile:
				let avc = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.ARTIST_VIEW_CONTROLLER) as! ArtistViewController
				let song = self.itemSelected as! Song
				avc.bandID = "\(song.band.bandID)"//"\(song.band.bandID)"
				
				self.navController?.navigateToController(avc)
				break
				
			case .AddToPlaylist:
				let pvc = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.PLAYLIST_VIEW_CONTROLLER) as! PlaylistViewController
				self.navController?.navigateToController(pvc)
				
				break
			
			case .PlayPlaylist:
				let apiRequest = APIRequest(requestType: APIRequest.RequestType.PlaylistDetails, requestParameters: [APIRequestParameter(key: "", value: "\(self.itemSelected?.getItemID())")])

				APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, apiReferrer: nil, postData: nil)
				break
			
			case .Subscribe:
				let apiRequest = APIRequest(requestType: APIRequest.RequestType.Subscribe, requestParameters: [APIRequestParameter(key: "\(self.itemSelected?.getItemID())", value: "subscribe")])
				
				APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, apiReferrer: nil, postData: nil)
				break
			
			case .Unsubscribe:
				let apiRequest = APIRequest(requestType: APIRequest.RequestType.Unsubscribe, requestParameters: [APIRequestParameter(key: "\(self.itemSelected?.getItemID())", value: "subscribe")])
				
				APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, apiReferrer: nil, postData: nil)
				break
			
			case .Follow:
				if self.itemSelected?.shareableType() == .Band
				{
					let apiRequest = APIRequest(requestType: APIRequest.RequestType.FollowBand, requestParameters: [APIRequestParameter(key: "", value: "\(self.itemSelected?.getItemID())")])
				
					APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, apiReferrer: nil, postData: nil)
				}
				else
				{
					let apiRequest = APIRequest(requestType: APIRequest.RequestType.FollowUser, requestParameters: [APIRequestParameter(key: "", value: "\(self.itemSelected?.getItemID())")])
					
					APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, apiReferrer: nil, postData: nil)
				}
				break
			
			case .Unfollow:
				if self.itemSelected?.shareableType() == .Band
				{
					let apiRequest = APIRequest(requestType: APIRequest.RequestType.UnfollowBand, requestParameters: [APIRequestParameter(key: "", value: "\(self.itemSelected?.getItemID())")])
				
					APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, apiReferrer: nil, postData: nil)
				}
				else
				{
					let apiRequest = APIRequest(requestType: APIRequest.RequestType.UnfollowUser, requestParameters: [APIRequestParameter(key: "", value: "\(self.itemSelected?.getItemID())")])
					
					APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, apiReferrer: nil, postData: nil)
				}
				break
			
			case .Share:
				/*var str = "string"
				var url = NSURL(string: "www.yahoo.com")
				let objectsToShare = NSArray(objects: str, url!)
				var activityVC = UIActivityViewController(activityItems: objectsToShare as [AnyObject], applicationActivities: nil)
				self.presentViewController(activityVC, animated: true, completion:
					{ () -> Void in
						
				})*/
				
				//let searchItem = data as! SearchItem
				//let song = self.itemSelected as! Shareable
				self.shareItem(self.itemSelected!)
				
				break
			}
	}
	
	func shareItem(item: Shareable)
	{
		let provider = ShareProvider()
		provider.shareableObject = item
		
		let activityItems = [provider, "", item.getShareURL()]
		
		//let applicationActivities = nil//[MZWhatsAppActivity()]
		
		let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
		activityVC.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
		activityVC.excludedActivityTypes =
		[
				UIActivityTypePrint,
				UIActivityTypeCopyToPasteboard,
				UIActivityTypeAssignToContact,
				UIActivityTypeSaveToCameraRoll,
				UIActivityTypeAirDrop,
				UIActivityTypeAddToReadingList
		]
		
		activityVC.completionWithItemsHandler =
		{
			(activityType: String!, completed: Bool, items: [AnyObject]!, error: NSError!) in
				
		}
		
		self.presentViewController(activityVC, animated: true, completion: nil)
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
	func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject?)
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
