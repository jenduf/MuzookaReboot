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
			}
			
			//self.producerIcon.hidden = song!.producerVotes == 0
			
				//if song!.band.following == true
			//{
			//	self.voteButton.selected = true
			//}
			
			//self.albumArtView.artURL = song!.artwork
		}
		
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
