//
//  SelectAirportCell.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 28..
//

import UIKit

class AirportCell: UITableViewCell {
    
    static let cellID = "AirportCell"

    
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var iataCodeLabel: UILabel!
    @IBOutlet weak var airportNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var currentAirport: Airport! {
        didSet {
            iataCodeLabel.text = currentAirport.iataCode
            airportNameLabel.text = currentAirport.airportName
        }
    }

}
