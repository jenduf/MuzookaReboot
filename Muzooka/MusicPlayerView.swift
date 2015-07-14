//
//  MusicPlayerView.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/4/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class MusicPlayerView: UIView
{
	@IBOutlet var title: UILabel!
	@IBOutlet var band: UILabel!
	@IBOutlet var producerIcon: UIImageView!
	@IBOutlet var likeButton: UIButton!
	@IBOutlet var time: UILabel!
	@IBOutlet var totalTime: UILabel!
	@IBOutlet var topConstraint: NSLayoutConstraint!
	@IBOutlet var playPauseButton: UIButton!
	@IBOutlet var indicatorView: IndicatorView!
	@IBOutlet var albumArtView: AlbumArtView!
	@IBOutlet var albumImageView: UIImageView!
	
	var song: Song?
	{
		didSet
		{
			self.title.text = song!.name
			self.band.text = song!.band.name
			
			if song!.band.following == true
			{
				self.likeButton.selected = true
			}
			
			if self.producerIcon != nil
			{
				self.producerIcon.hidden = song!.producerVotes == 0
			}
			
			if self.albumArtView != nil
			{
				self.albumArtView.artURL = song!.artwork!
			}
			
			if self.albumImageView != nil
			{
				self.albumImageView.loadFromURL(NSURL(string: song!.artwork!)!)
			}
		}
	}
	
	override func layoutSubviews()
	{
		super.layoutSubviews()
		
		/*
		var lightBlur = UIBlurEffect(style: .Dark)
		
		let veView = UIVisualEffectView(effect: lightBlur)
		veView.frame = self.bounds
		veView.alpha = 0.25
		
		println("bounds \(self.bounds)")
		
		self.insertSubview(veView, aboveSubview: self.albumArtView)*/
		//self.albumArtView.albumImageView.image = self.blurImage(self.albumArtView.albumImageView.image!)
	}
	
	func togglePlayButton()
	{
		self.playPauseButton.selected = !self.playPauseButton.selected
	}
	
	func setPercent(percent: CGFloat)
	{
		self.indicatorView.percent = percent
	}
	
	func blurImage(image: UIImage) -> UIImage
	{
		var imageToBlur = CIImage(image: image)
		var blurFilter = CIFilter(name: "CIGaussianBlur")
		blurFilter.setValue(imageToBlur, forKey: "inputImage")
		var resultImage = blurFilter.valueForKey("outputImage") as! CIImage
		var blurredImage = UIImage(CIImage: resultImage)
		return blurredImage!
	}

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
