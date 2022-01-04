//
//  DiscountClubCell.swift
//  CheapPriceDetector
//
//  Created by grimmdaniel on 2021. 07. 22..
//

import UIKit

class DiscountClubCell: UITableViewCell {
    
    static let cellID = "DiscountClubCell"
    
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var discountClubSwitchLabel: UILabel!
    @IBOutlet weak var discountClubSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        selectionStyle = .none
        cellBackgroundView.layer.cornerRadius = 8.0
        cellBackgroundView.clipsToBounds = true
        
        discountClubSwitch.onTintColor = ColorTheme.primaryColor
        discountClubSwitchLabel.text = "selectFlightVC_wdc_prices".localized
    }

}
