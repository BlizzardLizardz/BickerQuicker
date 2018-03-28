//
//  GenderedBickerCellTableViewCell.swift
//  BickerQuicker
//
//  Created by Brendan Raftery on 3/1/18.
//  Copyright © 2018 Jonathan Grider. All rights reserved.
//

import UIKit

class GenderedBickerCell: UITableViewCell {
  
  @IBOutlet weak var leftBannerView: UIView!
  @IBOutlet weak var rightBannerView: UIView!
  @IBOutlet weak var medianView: UIView!
  @IBOutlet weak var hisSideLabel: UILabel!
  @IBOutlet weak var herSideLabel: UILabel!
  @IBOutlet weak var leftSideText: UILabel!
  @IBOutlet weak var rightSideText: UILabel!
  @IBOutlet weak var rightSideBorder: UIView!
  @IBOutlet weak var rightSideBackground: UIView!
  @IBOutlet weak var leftSideBackground: UIView!
  @IBOutlet weak var leftSideBorder: UIView!
  
  var bicker: Bicker! {
    didSet {
      leftSideText.text = bicker.leftText
      rightSideText.text = bicker.rightText
      
      // TODO: Update later with more stuffs
        leftBannerView.clipsToBounds = true;
        leftBannerView.layer.cornerRadius = 7
        leftBannerView.layer.maskedCorners = [.layerMinXMinYCorner]
        
        rightBannerView.clipsToBounds = true;
        rightBannerView.layer.cornerRadius = 7
        rightBannerView.layer.maskedCorners = [.layerMaxXMinYCorner]
        
        leftSideBorder.clipsToBounds = true;
        leftSideBorder.layer.cornerRadius = 7
        leftSideBorder.layer.maskedCorners = [.layerMinXMaxYCorner]
        
        rightSideBorder.clipsToBounds = true;
        rightSideBorder.layer.cornerRadius = 7
        rightSideBorder.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        leftSideBackground.clipsToBounds = true;
        leftSideBackground.layer.cornerRadius = 6
        leftSideBackground.layer.maskedCorners = [.layerMinXMaxYCorner]
        
        rightSideBackground.clipsToBounds = true;
        rightSideBackground.layer.cornerRadius = 6
        rightSideBackground.layer.maskedCorners = [.layerMaxXMaxYCorner]
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
