//
//  PartnerViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class PartnerViewController: MuzookaViewController, UITableViewDataSource, UITableViewDelegate
{

	var partners = [Partner]()
	
	@IBOutlet var partnerTableView: UITableView!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		let apiRequest = APIRequest(requestType: APIRequest.RequestType.Partner, requestParameters: nil)

		APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	// MARK: - Table View
	func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return self.partners.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCellWithIdentifier(Constants.PARTNER_CELL_IDENTIFIER, forIndexPath: indexPath) as! PartnerCell
		
		var partner = self.partners[indexPath.row]
		
		cell.partner = partner
		
		return cell
	}
	
	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject?)
	{
		super.apiManagerDidReturnData(apiManager, data: data)
		
		self.partners.removeAll()
		
		var dataDict:NSDictionary = data as! NSDictionary
		
		var partnerArray:NSArray = dataDict["current"] as! NSArray
		
		for eachPartner in partnerArray
		{
			var partner = Partner(dict:eachPartner as! NSDictionary)
			self.partners.append(partner)
		}
		
		self.partnerTableView.reloadData()
	}

}
