//
//  SettingsViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class SettingsViewController: MuzookaViewController, UITableViewDelegate, UITableViewDataSource
{

	override func viewDidLoad()
	{
        super.viewDidLoad()

        // Do any additional setup after loading the view.
	}
	
	@IBAction func logout(sender: AnyObject)
	{
		self.navController!.logout()
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
	
	// MARK: Table View Methods
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return Settings.getSettingsValuesForLoginState().count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		var cell: SettingsCell = tableView.dequeueReusableCellWithIdentifier(Constants.SETTINGS_CELL_IDENTIFIER, forIndexPath: indexPath) as! SettingsCell
		
		cell.settingsLabel?.text = Settings.getSettingsValuesForLoginState()[indexPath.row].description
		
		return cell
	}

}
