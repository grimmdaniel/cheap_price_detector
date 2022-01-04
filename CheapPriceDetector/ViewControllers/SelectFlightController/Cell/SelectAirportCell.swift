//
//  SelectAirportCell.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 20..
//

import UIKit

class SelectAirportCell: UITableViewCell {
    
    static let cellID = "SelectAirportCell"
    
    
    @IBOutlet weak var cellBackgroundView: UIView!
    
    @IBOutlet weak var originAirportBackgroundView: UIView!
    
    @IBOutlet weak var destinationAirportBackgroundView: UIView!
    
    @IBOutlet weak var originImageBackgroundView: UIView!
    
    @IBOutlet weak var destinationImageBackgroundView: UIView!
    
    @IBOutlet weak var originImageView: UIImageView!
    
    @IBOutlet weak var destinationImageView: UIImageView!
    
    
    @IBOutlet weak var originDataBackgroundView: UIView!
    
    @IBOutlet weak var destinationDataBackgroundView: UIView!
    
    
    @IBOutlet weak var separatorViewBackground: UIView!
    
    @IBOutlet weak var separatorView: UIView!
    
    
    
    @IBOutlet weak var originAirportLabel: UILabel!
    
    @IBOutlet weak var originAirportNameLabel: UILabel!
    
    
    @IBOutlet weak var destinationAirportLabel: UILabel!
    
    @IBOutlet weak var destinationAirportNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
        cellBackgroundView.layer.cornerRadius = 8.0
        cellBackgroundView.clipsToBounds = true
        originAirportLabel.text = "selectFlightVC_origin_airport".localized
        destinationAirportLabel.text = "selectFlightVC_destination_airport".localized
    }
    
    var currentJourney: Journey! {
        didSet {
            let namePlaceholder = "selectFlightVC_airport_name_placeholder".localized
            let codePlaceholder = "selectFlightVC_airport_code_placeholder".localized
    
            let origin = (currentJourney.originAirport?.iataCode ?? codePlaceholder)
            originAirportNameLabel.text = (currentJourney.originAirport?.airportName ?? namePlaceholder) + " (" + origin + ")"
            let destination = (currentJourney.destinationAirport?.iataCode ?? codePlaceholder)
            destinationAirportNameLabel.text = (currentJourney.destinationAirport?.airportName ?? namePlaceholder) + " (" + destination + ")"
        }
    }
}
