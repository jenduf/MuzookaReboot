//
//  LoginViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class LoginViewController: MuzookaViewController, GPPSignInDelegate
{
	@IBOutlet var loginScreens: [LoginView]!
	@IBOutlet var actionButton: BorderedButton!
	@IBOutlet var backButton: UIButton!
	@IBOutlet var titleLabel: UILabel!

	var currentLoginScreen: LoginScreen = LoginScreen.Intro

    override func viewDidLoad()
	{
		super.viewDidLoad()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func close(sender: AnyObject)
	{
		var currentLoginView = self.loginScreens[self.currentLoginScreen.rawValue]
		
		switch self.currentLoginScreen
		{
			case .Login:
				var paramDict = NSDictionary(objectsAndKeys: currentLoginView.emailTextField.text, "email", currentLoginView.passwordTextField.text, "password")
				APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.Login, delegate: self, parameters: paramDict)
				break
			
			case .Register:
				var paramDict = NSDictionary(objectsAndKeys: currentLoginView.nameTextField.text, "name", currentLoginView.userNameTextField.text, "username", currentLoginView.emailTextField.text, "email", currentLoginView.passwordTextField.text, "password")
				APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.Register, delegate: self, parameters: paramDict)
				break
			
			default:
				self.dismissViewControllerAnimated(true, completion: nil)
				break
		}
	}
	
	@IBAction func loginPathSelected(sender: UIButton)
	{
		var loginScreen:LoginScreen = LoginScreen(rawValue: sender.tag)!
		
		switch(loginScreen)
		{
			case .Google:
				
				var signIn = GPPSignIn.sharedInstance()
				signIn.shouldFetchGooglePlusUser = true
				signIn.clientID = Constants.GOOGLE_CLIENT_ID
				signIn.scopes = [kGTLAuthScopePlusLogin]
				//signIn.useClientIDForURLScheme = true
				signIn.delegate = self
				
				signIn.authenticate()

				break
			
			case .Facebook:
				let fbLogin = FBSDKLoginManager.new()
				fbLogin.logInWithReadPermissions(["email"], handler:
					{ (result: FBSDKLoginManagerLoginResult!, error: NSError!) -> Void in
						var paramDict = NSDictionary(objectsAndKeys: result.token.tokenString, "accessToken")
						APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.FacebookRegister, delegate: self, parameters: paramDict)
						
				})
				break
			
			case .Intro:
				
				// update action button title
				self.actionButton.setTitle(Constants.TITLE_CLOSE, forState: UIControlState.Normal)
				self.backButton.hidden = true
			
			case .Login:
				
				// update action button title
				self.actionButton.setTitle(Constants.TITLE_LOGIN, forState: UIControlState.Normal)
				self.backButton.hidden = false
				self.animateToScreen(loginScreen)
				
				break
				
			case .Register:
			
				// update action button title
				self.actionButton.setTitle(Constants.TITLE_DONE, forState: UIControlState.Normal)
				self.backButton.hidden = false
				self.animateToScreen(loginScreen)
				
				break
			
			default:
				
				break
		}
	}
	
	func animateToScreen(loginScreen: LoginScreen)
	{
		var oldLoginView = self.loginScreens[self.currentLoginScreen.rawValue]
		var newLoginView = self.loginScreens[loginScreen.rawValue]
		
		var isForward = loginScreen.rawValue > self.currentLoginScreen.rawValue
		
		if isForward
		{
			// update constraints
			oldLoginView.leadingConstraint.constant = -oldLoginView.frame.width
			oldLoginView.trailingConstraint.constant = oldLoginView.frame.width
			oldLoginView.setNeedsUpdateConstraints()
		}
		else
		{
			// update constraints
			oldLoginView.leadingConstraint.constant = oldLoginView.frame.width
			oldLoginView.trailingConstraint.constant = -oldLoginView.frame.width
			oldLoginView.setNeedsUpdateConstraints()
		}
		
		newLoginView.leadingConstraint.constant = 0
		newLoginView.trailingConstraint.constant = 0
		newLoginView.setNeedsUpdateConstraints()
		
		// animate
		UIView.animateWithDuration(0.3, animations:
		{ () -> Void in
			
			oldLoginView.layoutIfNeeded()
			newLoginView.layoutIfNeeded()
		},
		completion:
		{ (Bool) -> Void in
			self.currentLoginScreen = loginScreen
		})
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	// MARK: Google API Delegate Methods
	func finishedWithAuth(auth: GTMOAuth2Authentication!, error: NSError!)
	{
		var paramDict = NSDictionary(objectsAndKeys: auth.accessToken, "acToken")
		APIManager.sharedManager.getAPIRequestForDelegate(APIRequest.GoogleRegister, delegate: self, parameters: paramDict)
	}
	
	func didDisconnectWithError(error: NSError!)
	{
		
	}
	
	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject)
	{
		super.apiManagerDidReturnData(apiManager, data: data)
		
		switch apiManager.apiRequest!
		{
			case APIRequest.Login:
				var dict:NSDictionary = data as! NSDictionary
				
				apiManager.authToken = dict["token"] as? String
				
				var user = User(dict: dict["user"] as! NSDictionary)
				
				User.currentUser = user
				
				break
			
			case APIRequest.Register:
			
				break
			
			case APIRequest.GoogleRegister:
			
				break
			
			case APIRequest.FacebookRegister:
			
				break
			
			default:
			
				break
		}
		
		self.dismissViewControllerAnimated(true, completion: nil)
	}

	
}
