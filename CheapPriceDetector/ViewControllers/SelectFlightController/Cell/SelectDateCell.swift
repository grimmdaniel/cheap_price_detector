//
//  SelectDateCell.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 22..
//

import UIKit

class SelectDateCell: UITableViewCell {
    
    static let cellID = "SelectDateCell"

    @IBOutlet weak var cellBackgroundView: UIView!
    
    
    @IBOutlet weak var departureDateNameLabel: UILabel!
    
    @IBOutlet weak var returnDateNameLabel: UILabel!
    
    @IBOutlet weak var departureDateValueLabel: UILabel!
    
    @IBOutlet weak var returnDateValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
        cellBackgroundView.layer.cornerRadius = 8.0
        cellBackgroundView.clipsToBounds = true
        departureDateNameLabel.text = "selectFlightVC_departure_date".localized
        returnDateNameLabel.text = "selectFlightVC_return_date".localized
    }

    var currentJourney: Journey! {
        didSet {
            departureDateValueLabel.text = currentJourney.formattedDepartureDate.replacingOccurrences(of: "-", with: ". ") + "."
            returnDateValueLabel.text = currentJourney.formattedReturnDate.replacingOccurrences(of: "-", with: ". ") + "."
        }
    }
}
