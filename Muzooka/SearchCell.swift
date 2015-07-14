//
//  SearchCell.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 6/1/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell
{
	@IBOutlet var searchText: UILabel!
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var descriptionLabel: UILabel!
	@IBOutlet var albumArtView: AlbumArtView!
	@IBOutlet var avatarView: AvatarView!
	@IBOutlet var producerIcon: UIImageView!
	@IBOutlet var actionButton: UIButton!
	@IBOutlet var bandImageView: UIImageView!
	@IBOutlet var overlayView: UIView!
	
	var cellDelegate: MuzookaCellDelegate!
	
	var searchItem: SearchItem?
		{
		didSet
		{
			self.titleLabel.text = searchItem!.getItemName()
			self.descriptionLabel.text = searchItem!.getItemDescription()
			
			if self.albumArtView != nil
			{
				if searchItem!.getArtwork() != nil
				{
					self.albumArtView.artURL = searchItem!.getArtwork()!
				}
				else
				{
					self.albumArtView.albumImageView.image = UIImage(named: Constants.IMAGE_DEFAULT_ART)
					self.albumArtView.gradientView.alpha = 1.0
				}
			}
			
			if self.bandImageView != nil
			{
				if searchItem!.getArtwork() != nil
				{
					self.bandImageView.loadFromURLWithCallback(NSURL(string:searchItem!.getArtwork()!)!, callback:
					{ (image) -> () in
							self.bandImageView.image = image
							self.overlayView.alpha = 1.0
					})
				}
				else
				{
					self.bandImageView.image = UIImage(named: Constants.IMAGE_DEFAULT_ART)
					self.overlayView.alpha = 1.0
				}
				
			}
			
			if self.avatarView != nil
			{
				self.avatarView.user = searchItem!.user
			}
			
			if self.producerIcon != nil
			{
				if searchItem!.song != nil
				{
					self.producerIcon.hidden = searchItem!.song!.producerVotes == 0
				}
			}
			
			if self.actionButton != nil
			{
				if searchItem!.band != nil
				{
					self.actionButton.selected = searchItem!.band!.following == true
				}
				else if searchItem!.song != nil
				{
					self.actionButton.selected = searchItem!.song!.userVoted == true
				}
			}
		}
		
	}
	
	@IBAction func showMenu(sender: AnyObject)
	{
		self.cellDelegate!.cellRequestedShowMenu(self, item: self.searchItem!)
	}
	
	@IBAction func actionButtonPressed(sender: AnyObject)
	{
		let btn = sender as! UIButton
		btn.selected = !btn.selected
		
		self.cellDelegate!.cellRequestedAction(self, item: self.searchItem!)
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	override func prepareForReuse()
	{
		super.prepareForReuse()
		
		if self.searchText != nil
		{
			self.searchText.text = ""
		}
		
		if self.titleLabel != nil
		{
			self.titleLabel.text = ""
		}
		
		if self.descriptionLabel != nil
		{
			self.descriptionLabel.text = ""
		}
		
		if self.albumArtView != nil
		{
			self.albumArtView.prepareForReuse()
		}
		
		if self.avatarView != nil
		{
			self.avatarView.image = nil
		}
		
		if self.bandImageView != nil
		{
			self.bandImageView.image = nil
		}
		
		if self.producerIcon != nil
		{
			self.producerIcon.image = nil
		}
		
		if self.actionButton != nil
		{
			self.actionButton = nil
		}
		
		if self.overlayView != nil
		{
			self.overlayView.alpha = 0.0
		}
	}

}
