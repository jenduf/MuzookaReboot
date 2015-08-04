//
//  FilterViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/2/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class FilterViewController: MuzookaViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate
{
	@IBOutlet var tagCollectionView: UICollectionView!
    @IBOutlet var searchTextField: UITextField!
    
	var tagCollections: TagCollections?
	
	
	override func viewDidLoad()
	{
		super.viewDidLoad()

		
	}
	
	override func loadData()
	{
		super.loadData()
		
		var apiRequest = APIRequest(requestType: APIRequest.RequestType.Tags, requestParameters: nil)
		APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, apiReferrer: nil)
	}
    
    @IBAction func search(sender: AnyObject?)
    {
        var apiRequest = APIRequest(requestType: APIRequest.RequestType.SearchTags, requestParameters: [APIRequestParameter(key: "", value:  "\(self.searchTextField.text)")])
        APIManager.sharedManager.getAPIRequestForDelegate(apiRequest, delegate: self, apiReferrer: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	// MARK: UICollectionViewDataSource
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
	{
		if let sectionCount = self.tagCollections?.getSectionCount()
        {
			return sectionCount
		}
		
		return 0
	}
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		if let rowCount = self.tagCollections?.getRowCountForTagSection(section)
        {
			return rowCount
		}
		
		return 0
	}
	
	func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
	{
		let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: Constants.FILTER_HEADER_IDENTIFIER, forIndexPath: indexPath) as! UICollectionReusableView
		//headerView.frame = CGRect(x: Constants.SIDE_PADDING, y: (CGFloat(indexPath.section) * Constants.FILTER_HEADER_HEIGHT), width: collectionView.width - (Constants.SIDE_PADDING * 2), height: Constants.FILTER_HEADER_HEIGHT)
		
		if let tagSection = self.tagCollections?.getTagSectionAtIndex(indexPath.section)
        {
            let headerText = UILabel(frame: CGRect(x: Constants.SIDE_PADDING, y: 0, width: headerView.width - (Constants.SIDE_PADDING * 2), height: headerView.height))
            headerText.font = UIFont(name: Constants.FONT_PROXIMA_NOVA_SEMIBOLD, size: Constants.FONT_SIZE_TAG_HEADER)
            headerText.text = tagSection.stringValue
            
            headerText.textColor = UIColor.blackColor()
            headerView.addSubview(headerText)
            //headerText.sizeToFit()
            //headerText.centerVerticallyInSuperView()
            //headerText.left = Constants.SIDE_PADDING
            //headerText.left = Constants.SIDE_PADDING
            
            println("indexPath: \(indexPath) tagSection: \(tagSection.stringValue)")
        }
		
		return headerView
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.TAG_CELL_IDENTIFIER, forIndexPath: indexPath) as! TagCollectionCell
		
		if let tagSection = self.tagCollections?.getTagSectionAtIndex(indexPath.section)
		{
			if let tagInfo = self.tagCollections?.getTagInfoForTagSectionAtRowIndex(tagSection, index: indexPath.row)
            {
                cell.tagText.text = tagInfo.name
            }
		}
		
		return cell
	}
	
    /*
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
	{
		return UIEdgeInsets(top: 0.0, left: Constants.SIDE_PADDING, bottom: 0.0, right: Constants.SIDE_PADDING)
	}*/
	
	// MARK: UICollectionViewDelegate
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
	{
		if let tagSection = self.tagCollections?.getTagSectionAtIndex(indexPath.section)
        {
            if let tagInfo = self.tagCollections?.getTagInfoForTagSectionAtRowIndex(tagSection, index: indexPath.row)
            {
                let cell = collectionView.cellForItemAtIndexPath(indexPath)
                cell!.selected = !cell!.selected
                
                SearchController.sharedController.addFilter(tagInfo.name)
            }
            
        }
	}
	
	func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath)
	{
        if let tagSection = self.tagCollections?.getTagSectionAtIndex(indexPath.section)
        {
            if let tagInfo = self.tagCollections?.getTagInfoForTagSectionAtRowIndex(tagSection, index: indexPath.row)
            {
                SearchController.sharedController.removeFilter(tagInfo.name)
            }
        }
	}
	
	
	// MARK: UICollectionViewDelegateFlowLayout Methods
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
	{
		
        if let tagSection = self.tagCollections?.getTagSectionAtIndex(indexPath.section)
        {
            if let tagInfo = self.tagCollections?.getTagInfoForTagSectionAtRowIndex(tagSection, index: indexPath.row)
            {
                let size = CGSize(width: self.view.width, height: Constants.TAG_CELL_HEIGHT)
                
                let rowSize = Utils.getCellHeightForFont(UIFont(name: Constants.FONT_PROXIMA_NOVA_REGULAR, size: Constants.FONT_SIZE_BIO_CELL)!, text: tagInfo.name, bounds: size)
                
                return CGSize(width: (rowSize.width + Constants.TAG_CELL_HEIGHT), height: Constants.TAG_CELL_HEIGHT)
            }
		
		//let charCount = count(tagInfo!.name)
		
	//	let newWidth = tagInfo!.getWidthOfString()
        }
        
        return CGSize.zeroSize
        
		//let charCount = count(tagInfo!.name)
		
		//return CGSize(width: (newWidth + Constants.FILTER_HEIGHT), height: Constants.FILTER_HEIGHT)
		
		//return CGSize(width: CGFloat(charCount) * 15, height: 40)
	}
	
    /*
	// MARK: StackedGridLayoutDelegate Methods
	func collectionView(collectionView: UICollectionView, layout cvl: UICollectionViewLayout, numberOfColumnsInSection section: Int) -> Int
	{
		return 3
	}
	
	func collectionView(collectionView: UICollectionView, layout cvl: UICollectionViewLayout, itemInsetsForSectionAtIndex section: Int) -> UIEdgeInsets
	{
		return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 10.0)
	}
	
	func collectionView(collectionView: UICollectionView, layout cvl: UICollectionViewLayout, sizeForItemWithWidth width: CGFloat, atIndexPath indexPath: NSIndexPath) -> CGSize
	{
		let tagSection = TagCollections.TagSection(rawValue: indexPath.section)
		
		let tagInfo = self.tagCollections?.getTagInfoForTagSectionAtRowIndex(tagSection!, index: indexPath.row)
		
		let newWidth = tagInfo!.getWidthOfString()
		
		//let charCount = count(tagInfo!.name)
		
		return CGSize(width: (newWidth + Constants.SIDE_PADDING), height: Constants.FILTER_HEIGHT)
		//CGSize(width: CGFloat(charCount) * 15, height: 40)
	}
*/
	
    // MARK: Text Field Delegate Methods
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool
    {
        return true
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if !textField.text.isEmpty
        {
            self.search(nil)
        }
        
        return true
    }
	
	// MARK: API Delegate Methods
	override func apiManagerDidReturnData(apiManager: APIManager, data: AnyObject?)
	{
		super.apiManagerDidReturnData(apiManager, data: data)
		
		var dataDict:NSDictionary = data as! NSDictionary
		
		switch apiManager.apiRequest!.requestType
		{
			case .Tags:
				self.tagCollections = TagCollections(dict: dataDict)
				
				self.tagCollectionView.reloadData()
			
				break
			
			case .SearchTags:
                self.tagCollections = TagCollections(dict: dataDict)
                
                self.tagCollectionView.reloadData()
                
				break
			
			default:
			
				break
		}
	}

}
