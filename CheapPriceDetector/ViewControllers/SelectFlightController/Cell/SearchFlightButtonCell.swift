//
//  SearchFlightButtonCell.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 20..
//

import UIKit

class SearchFlightButtonCell: UITableViewCell {
    
    static let cellID = "SearchFlightButtonCell"

    @IBOutlet weak var searchFlightButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchFlightButton.backgroundColor = ColorTheme.primaryColor
        searchFlightButton.setTitleColor(UIColor.white, for: .normal)
        searchFlightButton.layer.cornerRadius = 6.0
        backgroundColor = .clear
        selectionStyle = .none
        searchFlightButton.setTitle("selectFlightVC_search_flight_button".localized, for: .normal)
    }
    
}
