//
//  ResetSearchCell.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 22..
//

import UIKit

class ResetSearchCell: UITableViewCell {
    
    static let cellID = "ResetSearchCell"

    @IBOutlet weak var resetSearchButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resetSearchButton.backgroundColor = .clear
        resetSearchButton.setTitleColor(ColorTheme.secondaryColor, for: .normal)
        resetSearchButton.layer.cornerRadius = 6.0
        backgroundColor = .clear
        selectionStyle = .none
        resetSearchButton.setTitle("selectFlightVC_new_search_button".localized, for: .normal)
    }
}
