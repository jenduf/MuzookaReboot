//
//  MuzookaNavController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/4/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit
import AVFoundation

class MuzookaNavController: UIViewController, SegmentViewDelegate, UITableViewDataSource, UITableViewDelegate, APIDelegate, AvatarDelegate, MusicPlayerDelegate
{
	@IBOutlet var navHeaderView: NavHeaderView!
	@IBOutlet var mainContentView: NavContentView!
	@IBOutlet var leftNavView: LeftNavView!
	@IBOutlet var menuTableView: UITableView!
	@IBOutlet var contentHolderView: UIView!
	@IBOutlet var loadingAnimationView: LoadingAnimationView!
	@IBOutlet var musicPlayerView: MusicPlayerView!
	
	@IBOutlet var contentTopConstraint: NSLayoutConstraint!
	
	override func viewDidLoad()
	{
		super.viewDidLoad();
		
		// determine whether to show first time controller
		var isFirstTime = !NSUserDefaults.standardUserDefaults().boolForKey(Constants.FIRST_TIME_USE_SHOWN_KEY)
		
		if isFirstTime == true
		{
			let timeOffset = Int64(2.0 * Double(NSEC_PER_SEC))
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, timeOffset), dispatch_get_main_queue())
			{
				let ftvc = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.FIRST_TIME_VIEW_CONTROLLER) as! MuzookaViewController
				self.presentViewController(ftvc, animated: true, completion:
					{ () -> Void in
						ftvc.navController = self
					})
			}
		}
			
		self.navHeaderView.segmentView.delegate = self
		
		// if logged in, load user details
		if (APIManager.sharedManager.authToken != nil && !(APIManager.sharedManager.authToken!.isEmpty))
		{
			APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.User, delegate: self)
		}
		else
		{
			self.topViewController()!.loadData()
		}
		
		// initialize menu
		self.selectedMenuItem = Menu.Charts
		
		// set up first screen
		self.updateForScreen(NavScreen.Charts)
		
		self.menuTableView.reloadData()
	}

	override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
		
	}
	
	func updateForScreen(screen: NavScreen)
	{
		if screen.subHeadings.count == 0
		{
			//println("NAV Y: \(self.navHeaderView.navBarView.frame.maxY)")
			
			self.navHeaderView.heightConstraint.constant = self.navHeaderView.navBarView.frame.maxY
			
			self.navHeaderView.setNeedsUpdateConstraints()
			
			//self.contentHolderView.setNeedsUpdateConstraints()
			
			UIView.animateWithDuration(0.2, animations:
			{ () -> Void in
				self.navHeaderView.layoutIfNeeded()
				//self.contentHolderView.layoutIfNeeded()
			},
			completion:
			{ (Bool) -> Void in
				self.navHeaderView.updateForScreen(screen)
			})
		}
		else
		{
			//println("NAV Y: \(self.navHeaderView.frame.maxY + self.navHeaderView.navBarView.frame.height) SEGMENT: \(self.navHeaderView.segmentView.frame.maxY)")
			
			if self.navHeaderView.segmentView.frame.height > 0
			{
				self.navHeaderView.heightConstraint.constant = self.navHeaderView.segmentView.frame.maxY
			}
			else
			{
				self.navHeaderView.heightConstraint.constant = self.navHeaderView.frame.maxY + self.navHeaderView.navBarView.frame.height
			}
			
			self.navHeaderView.setNeedsUpdateConstraints()
			
			//	self.contentHolderView.setNeedsUpdateConstraints()
			
			UIView.animateWithDuration(0.2, animations:
			{ () -> Void in
				self.navHeaderView.layoutIfNeeded()
				//	self.contentHolderView.layoutIfNeeded()
			},
			completion:
			{ (Bool) -> Void in
				self.navHeaderView.updateForScreen(screen)
			})
		}
		
		if screen.showNavBar == true
		{
			if self.contentTopConstraint.constant < 0
			{
				self.contentTopConstraint.constant = 0
				
				self.contentHolderView.setNeedsUpdateConstraints()
			}
		}
		else
		{
			self.contentTopConstraint.constant = -self.navHeaderView.frame.height
			
			self.contentHolderView.setNeedsUpdateConstraints()
			
		}
		
		var alphaValue = CGFloat(screen.showNavBar == true ? 1.0 : 0.0)
		
		UIView.animateWithDuration(0.2, animations:
		{ () -> Void in
			self.navHeaderView.backgroundColor = self.navHeaderView.backgroundColor!.colorWithAlphaComponent(alphaValue)
		})
		
		/*
		UIView.animateWithDuration(0.4, delay: 0.1, options: UIViewAnimationOptions.CurveLinear, animations:
		{ () -> Void in
			self.contentHolderView.layoutIfNeeded()
		},
		completion:
		{ (Bool) -> Void in
			
				
		})*/
		
		self.contentHolderView.layoutIfNeeded()
		
	}
	
	func toggleMusicPlayer()
	{
		if self.musicPlayerView.topConstraint.constant < 0
		{
			self.musicPlayerView.topConstraint.constant = 0
		}
		else
		{
			self.musicPlayerView.topConstraint.constant = -self.musicPlayerView.frame.height
			
		}
		
		self.musicPlayerView.setNeedsUpdateConstraints()
		
		UIView.animateWithDuration(0.3)
		{ () -> Void in
			
			self.musicPlayerView.layoutIfNeeded()
			
			//self.musicPlayerView.frame = CGRect(x: 0.0, y: self.view.frame.height - self.musicPlayerView.frame.height, width: self.musicPlayerView.frame.width, height: self.musicPlayerView.frame.height)
		}
	}
	
	func toggleLeftNav()
	{
		if self.leftNavView.leadingConstraint.constant < 0
		{
			self.mainContentView.leadingConstraint?.constant = self.leftNavView.frame.width
			self.mainContentView.trailingConstraint?.constant = -self.leftNavView.frame.width
			self.mainContentView.setNeedsUpdateConstraints()
			
			self.leftNavView.leadingConstraint?.constant = 0
			//self.leftNavView.trailingConstraint?.constant = (self.view.frame.width - self.leftNavView.frame.width)
			self.leftNavView.setNeedsUpdateConstraints()
		}
		else
		{
			self.mainContentView.leadingConstraint?.constant = 0
			self.mainContentView.trailingConstraint?.constant = 0
			self.mainContentView.setNeedsUpdateConstraints()
			
			self.leftNavView.leadingConstraint.constant = -self.leftNavView.frame.width
			//self.leftNavView.trailingConstraint.constant = self.view.frame.width
			self.leftNavView.setNeedsUpdateConstraints()
		}
		
		UIView.animateWithDuration(0.3, animations:
		{ () -> Void in
			
			self.mainContentView.layoutIfNeeded()
			self.leftNavView.layoutIfNeeded()
			self.leftNavView.viewWillDisplay()
		})
	}
	
	@IBAction func registerOrLogin(sender: AnyObject?)
	{
		self.toggleLeftNav()
		
		self.showLoginScreen()
	}
	
	@IBAction func clickMusicPlayer(sender: AnyObject)
	{
		MusicPlayer.sharedPlayer.toggleAVPlayer()
		
		//self.musicPlayerView.togglePlayButton()
	}
	
	@IBAction func doubleClickMusicPlayer(sender: AnyObject)
	{
		//MusicPlayer.sharedPlayer.toggleAVPlayer()
		self.toggleMusicPlayer()

		self.showModalViewController(Constants.EXTENDED_PLAYER_VIEW_CONTROLLER)
	}
	
	@IBAction func showProfile(gesture: UIGestureRecognizer)
	{
		self.toggleLeftNav()
		
		self.showNewViewController(Constants.PROFILE_VIEW_CONTROLLER)
	}
	
	@IBAction func navButtonSelected(sender: NavButton)
	{
		let buttonType = NavButtonType(rawValue: sender.tag)
		
		switch(buttonType!)
		{
			case .Hamburger:
				self.toggleLeftNav()
				break
			
			case .BackArrow:
				self.popViewController()
				break
			
			case .Funnel:
			
				break
			
			case .Add:
				self.topViewController()!.performButtonActionType(buttonType!)
				break
			
			default:
			
				break
		}
	}
	
	// MARK: - Navigation Methods

	func showLoginScreen()
	{
		let lvc = self.storyboard!.instantiateViewControllerWithIdentifier(Constants.LOGIN_VIEW_CONTROLLER) as! MuzookaViewController
		lvc.navController = self
		
		self.presentViewController(lvc, animated: true)
			{ () -> Void in
				
			}
	}
	
	func showModalViewController(identifier: String)
	{
		let mvc: MuzookaViewController = self.storyboard?.instantiateViewControllerWithIdentifier(identifier) as! MuzookaViewController
		self.addChildViewController(mvc)
		
		self.contentHolderView.addSubview(mvc.view)
		
		mvc.view.frame.origin = CGPoint(x: 0, y: self.view.frame.height)
		
		UIView.animateWithDuration(0.5, animations:
		{ () -> Void in
			mvc.view.frame.origin = CGPoint(x: 0, y: 0)
		})
		{ (Bool) -> Void in
			mvc.didMoveToParentViewController(self)
		}
		
		//var navScreen = NavScreen(rawValue: newController.view.tag)
				
		//		self.updateForScreen(navScreen!)
				//self.navBarView.updateForScreen(navScreen!)
	}
	
	func hideModalViewController()
	{
		let oldController = self.topViewController()
		
		UIView.animateWithDuration(0.5, animations:
		{ () -> Void in
			oldController!.view.frame.origin = CGPoint(x: 0, y: self.view.frame.height)
		},
		completion:
		{ (Bool) -> Void in
			oldController!.willMoveToParentViewController(nil)
			oldController!.removeFromParentViewController()
			oldController!.view.removeFromSuperview()
		})
	}
	
	func showNewViewController(identifier: String)
	{
		if !self.isTopViewController(identifier)
		{
			// remove current controller
			let viewControllerToRemove = self.topViewController()
			viewControllerToRemove!.view.removeFromSuperview()
			viewControllerToRemove!.removeFromParentViewController()
			viewControllerToRemove!.willMoveToParentViewController(nil)
			
			// add new controller
			let newViewController: MuzookaViewController = self.storyboard?.instantiateViewControllerWithIdentifier(identifier) as! MuzookaViewController
			self.addChildViewController(newViewController)
			newViewController.view.frame.size = self.contentHolderView.frame.size
			self.contentHolderView.addSubview(newViewController.view)
			newViewController.didMoveToParentViewController(self)
			
			newViewController.loadData()
			
			var navScreen = NavScreen(rawValue: newViewController.view.tag)
			self.updateForScreen(navScreen!)
		}
	}
	
	func navigateToControllerWithIdentifier(identifier: String)
	{
		let newController = self.storyboard?.instantiateViewControllerWithIdentifier(identifier) as! MuzookaViewController
		
		self.navigateToController(newController)
	}
	
	func navigateToController(newController: MuzookaViewController)
	{
		let oldController = self.topViewController()
		
		self.addChildViewController(newController)
		
		UIView.animateWithDuration(0.5, animations:
		{ () -> Void in
			oldController!.view.frame.origin = CGPoint(x: -oldController!.view.frame.width, y: oldController!.view.frame.origin.y)
		})
		{ (Bool) -> Void in
			oldController!.view.removeFromSuperview()
		}
		
		self.contentHolderView.addSubview(newController.view)
		
		newController.view.frame.origin = CGPoint(x: self.view.frame.width, y: newController.view.frame.origin.y)
		
		UIView.animateWithDuration(0.5, animations:
		{ () -> Void in
			newController.view.frame.origin = CGPoint(x: 0, y: newController.view.frame.origin.y)
		},
		completion:
		{ (Bool) -> Void in
			newController.didMoveToParentViewController(self)
			
			var navScreen = NavScreen(rawValue: newController.view.tag)
				
			self.updateForScreen(navScreen!)
			//self.navBarView.updateForScreen(navScreen!)
		})
	}
	
	func popViewController()
	{
		let oldController = self.topViewController()
		
		UIView.animateWithDuration(0.5, animations:
		{ () -> Void in
			oldController!.view.frame.origin = CGPoint(x: self.view.frame.width, y: oldController!.view.frame.origin.y)
		},
		completion:
		{ (Bool) -> Void in
			oldController!.willMoveToParentViewController(nil)
			oldController!.removeFromParentViewController()
			oldController!.view.removeFromSuperview()
		})
		
		let newController = self.secondTopViewController()
		
		self.contentHolderView.addSubview(newController!.view)
		
		newController!.view.frame.origin = CGPoint(x: -newController!.view.frame.width, y: newController!.view.frame.origin.y)
		
		UIView.animateWithDuration(0.5, animations:
		{ () -> Void in
			newController!.view.frame.origin = CGPoint(x: 0, y: newController!.view.frame.origin.y)
		},
		completion:
		{ (Bool) -> Void in
				
			newController!.didMoveToParentViewController(self)
				
			var navScreen = NavScreen(rawValue: newController!.view.tag)
			self.updateForScreen(navScreen!)
		})
	}
	
	func showLoader(show: Bool)
	{
		if show == true
		{
			// animate while loading data
			self.loadingAnimationView.startAnimating()
		}
		else
		{
			// stop animating loading
			self.loadingAnimationView.stopAnimating()
		}
	}

	func logout()
	{
		APIManager.sharedManager.authToken = ""
		User.currentUser = nil
		
		self.showNewViewController(Constants.CHART_VIEW_CONTROLLER)
	}
	
	// MARK: Segment View Delegate Methods
	func segmentViewDidSelectViewIndex(segmentView: SegmentView, index: Int)
	{
		var mvc = self.childViewControllers.last as! MuzookaViewController
		mvc.setSelectedIndex(index)
	}
	
	// MARK: Table View Methods
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return Menu.values.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		var cell: MenuCell = tableView.dequeueReusableCellWithIdentifier(Constants.MENU_CELL_IDENTIFIER, forIndexPath: indexPath) as! MenuCell
		
		cell.menuTitle?.text = Menu.values[indexPath.row].description
		cell.menuImage.image = UIImage(named: Menu.values[indexPath.row].imageName)
		cell.menuImage.highlightedImage = UIImage(named: "\(Menu.values[indexPath.row].imageName)_active")
		
		cell.active = (self.selectedMenuItem?.rawValue == indexPath.row)
		
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
	{
		var menuItem = Menu.values[indexPath.row]
		
		self.toggleLeftNav()
		
		self.selectedMenuItem = menuItem
	}
	
	// MARK: Helpers
	func topViewController() -> MuzookaViewController?
	{
		if self.childViewControllers.count == 0
		{
			return nil
		}
		
		return self.childViewControllers.last as? MuzookaViewController
	}
	
	func secondTopViewController() -> MuzookaViewController?
	{
		if self.childViewControllers.count < 2
		{
			return nil
		}
		
		return self.childViewControllers[self.childViewControllers.count - 2] as? MuzookaViewController
	}
	
	func isTopViewController(identifier: String) -> Bool
	{
		var currentIdentifier = NSStringFromClass(self.topViewController()!.classForCoder)
		var className = currentIdentifier.componentsSeparatedByString(".")[1]
		
		return (className == identifier)
	}

	// MARK: Select New Menu Item
	var selectedMenuItem: Menu?
	{
		didSet
		{
			//	var titleString = selectedMenuItem?.description
			
			//self.navBarView.title.text = titleString
			
			switch(selectedMenuItem!)
			{
				case .Charts:
					self.showNewViewController(Constants.CHART_VIEW_CONTROLLER)
					break
					
				case .Partners:
					self.showNewViewController(Constants.PARTNER_VIEW_CONTROLLER)
					break
					
				case .Industry:
					self.showNewViewController(Constants.INDUSTRY_VIEW_CONTROLLER)
					break
					
				case .Search:
					self.showNewViewController(Constants.SEARCH_VIEW_CONTROLLER)
					break
					
				case .Playlists:
					self.showNewViewController(Constants.PLAYLIST_VIEW_CONTROLLER)
					break
					
				case .Settings:
					self.showNewViewController(Constants.SETTINGS_VIEW_CONTROLLER)
					break
					
				default:
					break
				
			}
			
			self.menuTableView.reloadData()
		}
		
	}
	
	// MARK: Avatar Delegate Methods
	func avatarViewRequestedEdit(avatarView: AvatarView)
	{
		
		
	}
	
	// MARK: MusicPlayer Delegate Methods
	func musicPlayerDidUpdateTimeCode(musicPlayer: MusicPlayer, current: CMTime, total: CMTime)
	{
		let currentTotal = Int(CMTimeGetSeconds(current))
		
		let completeTotal = Float(CMTimeGetSeconds(total))
		
		let minutes = floorf(Float(currentTotal / 60))
		let seconds = floorf(Float(currentTotal % 60))
		
		self.musicPlayerView.time.text = String(format: "%02.0f:%02.0f", minutes, seconds) //"\(minutes) : \(seconds)"
		
		// calculate indicator width
		let indicatorPercent = Float(currentTotal) / completeTotal
		
		self.musicPlayerView.setPercent(CGFloat(indicatorPercent))
		
		//	println("total: \(completeTotal) current total: \(currentTotal) minutes: \(minutes) seconds: \(seconds) indicator percent: \(indicatorPercent)")
	}
	
	func musicPlayerDidStartPlaying(musicPlayer: MusicPlayer, song: Song)
	{
		self.toggleMusicPlayer()
		
		self.musicPlayerView.togglePlayButton()
		
		self.musicPlayerView.song = song
	}
	
	func musicPlayerDidToggle(musicPlayer: MusicPlayer)
	{
		self.musicPlayerView.togglePlayButton()
	}
	
	func musicPlayerSongDidEnd(musicPlayer: MusicPlayer)
	{
		
	}
	
	// MARK: API Delegate Methods
	func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject)
	{
		var dict:NSDictionary = data as! NSDictionary
		
		var user = User(dict: dict)
		
		User.currentUser = user
		
		self.topViewController()!.loadData()
	}
	
	func apiManagerDidReturnError(apiManager: APIManager, error: String)
	{
		
	}
	
	func apiManagerDidReturnNeedsAuthenticatedUser(apiManager: APIManager)
	{

	}
}