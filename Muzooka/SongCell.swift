//
//  SongCell.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/4/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell, VoteButtonViewDelegate
{
	@IBOutlet var songName: UILabel!
	@IBOutlet var bandName: UILabel!
	@IBOutlet var rank: UILabel!
	@IBOutlet var albumArtView: AlbumArtView!
	@IBOutlet var producerIcon: UIImageView!
	@IBOutlet var voteButtonView: VoteButtonView!
	@IBOutlet var menuButton: UIButton!
	
	var cellDelegate: MuzookaCellDelegate!
	
	var song: Song?
	{
		didSet
		{
			self.songName.text = song!.name
			self.bandName.text = song!.band.name
			//self.rank.text = "\(song!.position)"
			
			self.producerIcon.hidden = song!.producerVotes == 0
            
            if self.voteButtonView != nil
            {
                self.voteButtonView.setActive(song!.userVoted == true, animated: false)
            }
			
			if self.albumArtView != nil
			{
				let imageURL = ImageDimension.ExtraSmall.getImageDimensionAtURL(song!.artworkURL!) as String
				
				self.albumArtView.artURL =  imageURL
			}
		}
		
	}

	override func awakeFromNib()
	{
		super.awakeFromNib()
        
        self.voteButtonView.delegate = self
		
		//self.songArtwork.layer.masksToBounds = true
		//self.songArtwork.layer.cornerRadius = 2.0
	}
	
	@IBAction func showMenu(sender: AnyObject)
	{
		self.cellDelegate!.cellRequestedShowMenu(self, item: self.song!)
	}
	
	@IBAction func actionButtonPressed(sender: AnyObject)
	{
		let btn = sender as! UIButton
		btn.selected = !btn.selected
		
		self.cellDelegate!.cellRequestedAction(self, item: self.song!)
	}
	
	override func prepareForReuse()
	{
		super.prepareForReuse()
		
		self.songName.text = ""
		self.bandName.text = ""
		
		if self.rank != nil
		{
			self.rank.text = ""
		}
		
		if self.albumArtView != nil
		{
			self.albumArtView.albumImageView.image = nil
		}
        
        if self.voteButtonView != nil
        {
            self.voteButtonView.setActive(false, animated: false)
        }
	}

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	// MARK: VoteButtonView Delegate Methods
    func voteButtonSelected(voteButton: VoteButtonView)
    {
        self.cellDelegate.cellRequestedAction(self, item: self.song!)
    }
}
