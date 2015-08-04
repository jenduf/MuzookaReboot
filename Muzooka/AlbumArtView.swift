//
//  AlbumArtView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/28/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class AlbumArtView: UIView
{
	@IBOutlet var albumImageView: UIImageView!
	
	var artImageView: UIImageView?
	
	let gradientView = GradientView()
    
    var showDarkerVersion: Bool = false
    {
        didSet
        {
            self.setNeedsLayout()
        }
    }
	
	var artURL: String?
	{
		didSet
		{
			//let request = NSURLRequest(URL: NSURL(string: artURL!)!)
			//NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
			//{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
			//		if data != nil
			//		{
			//			let image = UIImage(data: data)
			//			self.albumImageView.image = image
			//		}
			//}
			self.albumImageView.loadFromURL(NSURL(string: artURL!)!)
		}
		
	}
	
	
	init(urlString: String, frame: CGRect)
	{
		super.init(frame: frame)
		
		self.artImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
		
		self.artImageView!.loadFromURLWithCallback(NSURL(string: urlString)!, callback:
		{ (downloadedImage) -> () in
			
			self.artImageView!.image = downloadedImage
						
			self.addSubview(self.artImageView!)
		})
	}

	required init(coder aDecoder: NSCoder)
	{
	    super.init(coder: aDecoder)
	}
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
	}
	
	override func awakeFromNib()
	{
		super.awakeFromNib()
		
		self.albumImageView.image = UIImage(named: Constants.IMAGE_DEFAULT_ART)
	}
	
	override func didMoveToWindow()
	{
		super.didMoveToWindow()
		
		self.addSubview(self.gradientView)
	}
	
	override func layoutSubviews()
	{
		super.layoutSubviews()
		
        if self.showDarkerVersion == true
        {
            self.gradientView.frame = CGRect(origin: CGPoint.zeroPoint, size: self.frame.size)
            
            self.gradientView.colors = [UIColor.blackColor().colorWithAlphaComponent(0.2).CGColor, UIColor.blackColor().colorWithAlphaComponent(0.9).CGColor]
        }
        else
        {
            self.gradientView.frame = CGRect(origin: CGPoint(x: 0, y: self.frame.height / 2), size: CGSize(width: self.frame.width, height: self.frame.height / 2))
            
            self.gradientView.colors = [UIColor.blackColor().colorWithAlphaComponent(0.0).CGColor, UIColor.blackColor().colorWithAlphaComponent(0.6).CGColor]
        }

		
		self.layer.cornerRadius = 2.0
		self.layer.masksToBounds = true
	}
	
	func prepareForReuse()
	{
		self.gradientView.alpha = 0.0
		self.albumImageView.image = nil
	}

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
