//
//  SongCell.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/4/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell
{
	@IBOutlet var songName: UILabel!
	@IBOutlet var bandName: UILabel!
	@IBOutlet var rank: UILabel!
	@IBOutlet var albumArtView: AlbumArtView!
	@IBOutlet var producerIcon: UIImageView!
	@IBOutlet var voteButton: UIButton!
	@IBOutlet var menuButton: UIButton!
	
	var song: Song?
	{
		didSet
		{
			self.songName.text = song!.name
			self.bandName.text = song!.band.name
			//self.rank.text = "\(song!.position)"
			
			self.producerIcon.hidden = song!.producerVotes == 0
			
			if song!.band.following == true
			{
				self.voteButton.selected = true
			}
			
			if self.albumArtView != nil
			{
				self.albumArtView.artURL = song!.artwork
			}
		}
		
	}

	override func awakeFromNib()
	{
		super.awakeFromNib()
		
		//self.songArtwork.layer.masksToBounds = true
		//self.songArtwork.layer.cornerRadius = 2.0
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
	}

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	

}
