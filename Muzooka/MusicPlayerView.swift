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
	@IBOutlet var sliderView: SliderView!
	
	@IBInspectable
	var shouldBlur: Bool = false
	
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
				self.albumImageView.loadFromURLWithCallback(NSURL(string: song!.artwork!)!, callback:
				{ (downloadedImage) -> () in
					if self.shouldBlur == true
					{
						self.albumImageView.blurImage(downloadedImage)
					}
					else
					{
						self.albumImageView.image = downloadedImage
					}
				})
				
				//self.albumImageView.loadFromURL(NSURL(string: song!.artwork!)!)
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
	
	@IBAction func playPause(sender: UIButton)
	{
		self.togglePlayButton()
		
		MusicPlayer.sharedPlayer.toggleAVPlayer()
	}
	
	func togglePlayButton()
	{
		self.playPauseButton.selected = !self.playPauseButton.selected
	}
	
	func updateTime(currentTime: String, totalTime: String, percent: CGFloat)
	{
		self.time.text = currentTime
		self.totalTime.text = totalTime
		
		self.setPercent(percent)
	}
	
	func setPercent(percent: CGFloat)
	{
		if self.indicatorView != nil
		{
			self.indicatorView.percent = percent
		}
		else if self.sliderView != nil
		{
			self.sliderView.percent = percent
		}
	}

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
