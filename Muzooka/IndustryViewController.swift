//
//  IndustryViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/5/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class IndustryViewController: MuzookaViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
	var producers = [Producer]()
	
	@IBOutlet var producerCollectionView: UICollectionView!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()

		let apiRequest = APIRequest(requestType: APIRequest.RequestType.Producers, requestParameters: nil)
		
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
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
	{
		return 1
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return self.producers.count
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.PRODUCER_CELL_IDENTIFIER, forIndexPath: indexPath) as! ProducerCell
		
		var producer = self.producers[indexPath.row]
		
		cell.producer = producer
		
		return cell
	}
	
	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject?)
	{
		super.apiManagerDidReturnData(apiManager, data: data)
		
		self.producers.removeAll()
		
		var producerArray:NSArray = data as! NSArray
		
		for eachProducer in producerArray
		{
			var producer = Producer(dict:eachProducer as! NSDictionary)
			self.producers.append(producer)
		}
		
		self.producerCollectionView.reloadData()
	}

}
