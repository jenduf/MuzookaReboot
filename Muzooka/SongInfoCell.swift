//
//  SongInfoCell.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/22/15.
//  Copyright (c) 2015 com.muzooka. All rights reserved.
//

import UIKit

class SongInfoCell: UITableViewCell
{
    @IBOutlet var avatar: AvatarView!
    @IBOutlet var industryImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var timeAgo: UILabel!
    @IBOutlet var followButton: UIButton!
    
    var vote: Vote?
    {
        didSet
        {
            self.userName.text = vote?.user?.name
            self.timeAgo.text = vote?.timeAgo
            self.avatar.avatarURL = vote?.user?.avatarURL
            
          //  self.industryImageView.hidden = song!.producerVotes == 0
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
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        
        if self.avatar != nil
        {
            self.avatar.image = nil
        }
        
        if self.industryImageView != nil
        {
            self.industryImageView.image = nil
        }
        
        if self.userName != nil
        {
            self.userName.text = ""
        }
        
        if self.timeAgo != nil
        {
            self.timeAgo.text = ""
        }
        
        if self.followButton != nil
        {
            self.followButton = nil
        }
    }

}
