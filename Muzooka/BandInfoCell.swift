//
//  BandInfoCell.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 7/23/15.
//  Copyright (c) 2015 com.muzooka. All rights reserved.
//

import UIKit

protocol BandInfoCellDelegate
{
    func bandInfoCellRequestedReadMore(cell: BandInfoCell, rect: CGRect)
}

class BandInfoCell: UITableViewCell
{
    @IBOutlet var songsLabel: UILabel!
    @IBOutlet var followersLabel: UILabel!
    @IBOutlet var bioLabel: UILabel!
    @IBOutlet var gradientView: GradientView!
    @IBOutlet var avatarView: AvatarView!
    @IBOutlet var bandName: UILabel!
    @IBOutlet var bandInstrument: UILabel!
    @IBOutlet var socialImage: UIImageView!
    @IBOutlet var socialLabel: UILabel!
    @IBOutlet var readMoreButton: UIButton!
    
    var showingMore: Bool = false
    
    var bandInfoCellDelegate: BandInfoCellDelegate?
    
    var band: Band?
    {
        didSet
        {
            if band != nil
            {
                if self.songsLabel != nil
                {
                    self.songsLabel.text = "\(band!.songs.count)"
                }
                
                if self.followersLabel != nil
                {
                    self.followersLabel.text = "\(band!.followers!)"
                }
                
                if self.bioLabel != nil
                {
                    var style = NSMutableParagraphStyle()
                    style.lineSpacing = Constants.LINE_SPACING;
                    
                    let attributes = [ NSParagraphStyleAttributeName : style, NSFontAttributeName : UIFont(name: Constants.FONT_PROXIMA_NOVA_SEMIBOLD, size: Constants.FONT_SIZE_BIO_CELL)! ]
                    
                    let attributedBioString = NSAttributedString(string: band!.bio!, attributes: attributes)
                    
                    let bioRect = attributedBioString.boundingRectWithSize(CGSize(width: self.bioLabel.width, height: CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
                    
                    if bioRect.size.height < Constants.BAND_INFO_CELL_HEIGHT
                    {
                        self.readMoreButton.hidden = true
                        self.gradientView.hidden = true
                    }
                    else
                    {
                        self.readMoreButton.hidden = false
                        self.gradientView.hidden = false
                    }
                    
                    self.bioLabel.attributedText = attributedBioString
                }
                
                if self.gradientView != nil
                {
                    self.gradientView.colors = [UIColor.whiteColor().colorWithAlphaComponent(0.0).CGColor, UIColor.whiteColor().colorWithAlphaComponent(0.8).CGColor]
                }
            }
        }
        
    }
    
    var bandMember: BandMember?
    {
        didSet
        {
          //  if self.avatarView != nil
            //{
              //  self.avatarView.avatarURL = bandMember?.avatar
            //}
            
            if self.bandName != nil
            {
                self.bandName.text = bandMember?.name
            }
            
            if self.bandInstrument != nil
            {
                self.bandInstrument.text = bandMember?.role
            }
        }
    }
    
    @IBAction func readMore(sender: AnyObject)
    {
        if self.showingMore == true
        {
            self.showingMore = false
            
            self.bandInfoCellDelegate?.bandInfoCellRequestedReadMore(self, rect: CGRect(origin: CGPoint.zeroPoint, size: CGSize.zeroSize))
            
            self.gradientView.alpha = 1.0
            
            self.readMoreButton.setTitle(Constants.TITLE_READ_MORE, forState: UIControlState.Normal)
        }
        else
        {
            self.showingMore = true
            
            var style = NSMutableParagraphStyle()
            style.lineSpacing = Constants.LINE_SPACING;
            
            let attributes = [ NSParagraphStyleAttributeName : style, NSFontAttributeName : self.bioLabel.font ]
            
            let attributedBioString = NSAttributedString(string: self.band!.bio!, attributes: attributes)
            
            let bioRect = attributedBioString.boundingRectWithSize(CGSize(width: self.bioLabel.width, height: CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)

            self.bandInfoCellDelegate?.bandInfoCellRequestedReadMore(self, rect: bioRect)
            
            self.gradientView.alpha = 0.0
            
            self.readMoreButton.setTitle(Constants.TITLE_SHOW_LESS, forState: UIControlState.Normal)
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
        
        if self.songsLabel != nil
        {
            self.songsLabel.text = ""
        }
        
        if self.followersLabel != nil
        {
            self.followersLabel.text = ""
        }
        
        if self.bioLabel != nil
        {
            self.bioLabel.text = ""
        }
        
        if self.avatarView != nil
        {
            //self.avatarView.avatarImageView.image = nil
        }
        
        if self.bandName != nil
        {
            self.bandName.text = ""
        }
        
        if self.bandInstrument != nil
        {
            self.bandInstrument.text = ""
        }
    }

}
