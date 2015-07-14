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
	
	@IBAction func login(sender: AnyObject)
	{
		var currentLoginView = self.loginScreens[self.currentLoginScreen.rawValue]
		
		var paramDict = NSDictionary(objectsAndKeys: currentLoginView.emailTextField.text, "email", currentLoginView.passwordTextField.text, "password")
		let apiRequest = APIRequest(requestType: APIRequest.RequestType.Login, requestParameters: nil)
		
		APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, postData: paramDict)
	}
	
	@IBAction func close(sender: AnyObject)
	{
		var currentLoginView = self.loginScreens[self.currentLoginScreen.rawValue]
		
		switch self.currentLoginScreen
		{
			case .Login:
				var paramDict = NSDictionary(objectsAndKeys: currentLoginView.emailTextField.text, "email", currentLoginView.passwordTextField.text, "password")
				let apiRequest = APIRequest(requestType: APIRequest.RequestType.Login, requestParameters: nil)
				APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, postData: paramDict)
				break
			
			case .Register:
				var paramDict = NSDictionary(objectsAndKeys: currentLoginView.nameTextField.text, "name", currentLoginView.userNameTextField.text, "username", currentLoginView.emailTextField.text, "email", currentLoginView.passwordTextField.text, "password")
				let apiRequest = APIRequest(requestType: APIRequest.RequestType.Register, requestParameters: nil)
				APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, postData: paramDict)
				break
			
			default:
				self.dismissViewControllerAnimated(true, completion: nil)
				break
		}
	}
	
	@IBAction func loginWithGoogle(sender: UIButton)
	{
		var signIn = GPPSignIn.sharedInstance()
		signIn.shouldFetchGooglePlusUser = true
		signIn.clientID = Constants.GOOGLE_CLIENT_ID
		signIn.scopes = [kGTLAuthScopePlusLogin]
		//signIn.useClientIDForURLScheme = true
		signIn.delegate = self
		
		signIn.authenticate()
	}
	
	@IBAction func loginWithFacebook(sender: UIButton)
	{
		let fbLogin = FBSDKLoginManager.new()
		fbLogin.logInWithReadPermissions(["email"], handler:
		{ (result: FBSDKLoginManagerLoginResult!, error: NSError!) -> Void in
			var paramDict = NSDictionary(objectsAndKeys: result.token.tokenString, "accessToken")
			let apiRequest = APIRequest(requestType: APIRequest.RequestType.FacebookRegister, requestParameters: nil)
			APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, postData: paramDict)
		
		})
	}
	
	@IBAction func loginWithEmail(sender: UIButton)
	{
		// update action button title
		//self.actionButton.setTitle(Constants.TITLE_LOGIN, forState: UIControlState.Normal)
		//self.backButton.hidden = false
		self.animateToScreen(LoginScreen.Login)
	}
	
	@IBAction func loginPathSelected(sender: UIButton)
	{
		var loginScreen:LoginScreen = LoginScreen(rawValue: sender.tag)!
		
		switch(loginScreen)
		{
			case .Intro:
				
				// update action button title
				self.actionButton.setTitle(Constants.TITLE_CLOSE, forState: UIControlState.Normal)
				self.backButton.hidden = true
				
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
		let apiRequest = APIRequest(requestType: APIRequest.RequestType.GoogleRegister, requestParameters: nil)
		APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, postData: paramDict)
	}
	
	func didDisconnectWithError(error: NSError!)
	{
		
	}
	
	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject?)
	{
		super.apiManagerDidReturnData(apiManager, data: data)
		
		switch apiManager.apiRequest!.requestType
		{
			case .Login:
				var dict:NSDictionary = data as! NSDictionary
				
				apiManager.authToken = dict["token"] as? String
				
				var user = User(dict: dict["user"] as! NSDictionary)
				
				User.currentUser = user
				
				break
			
			case .Register:
			
				break
			
			case .GoogleRegister:
			
				break
			
			case .FacebookRegister:
			
				break
			
			default:
			
				break
		}
		
		self.dismissViewControllerAnimated(true, completion: nil)
	}

	
}
