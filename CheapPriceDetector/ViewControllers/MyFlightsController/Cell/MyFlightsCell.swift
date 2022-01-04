//
//  MyFlightsCell.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 08. 24..
//

import UIKit

class MyFlightsCell: UITableViewCell {

    static let cellID = "MyFlightsCell"

    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var originAirportNameLabel: UILabel!
    @IBOutlet weak var originAirportCodeLabel: UILabel!
    @IBOutlet weak var destinationAirportNameLabel: UILabel!
    @IBOutlet weak var destinationAirportCodeLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var flightDateLabel: UILabel!
    @IBOutlet weak var airlineColorView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
        cellBackgroundView.layer.cornerRadius = 8.0
        cellBackgroundView.clipsToBounds = true
    }
    
    var currentMyFlight: MyFlight! {
        didSet {
            let placeholder = "N/A"
            originAirportNameLabel.text = currentMyFlight.originAirport?.airportName ?? placeholder
            originAirportCodeLabel.text = currentMyFlight.originAirport?.iataCode ?? placeholder
            destinationAirportNameLabel.text = currentMyFlight.arrivingAirport?.airportName ?? placeholder
            destinationAirportCodeLabel.text = currentMyFlight.arrivingAirport?.iataCode ?? placeholder
            let airlineName = currentMyFlight.airlineCompany?.name == nil ? "" : "(\(currentMyFlight.airlineCompany!.name))"
            flightNumberLabel.text = (currentMyFlight.airlineCompany?.abbreviation ?? "") + " " + (currentMyFlight.flightNumber ?? "") + " " +  airlineName
            flightDateLabel.text = currentMyFlight.date.wizzDateFormat()
            airlineColorView.backgroundColor = currentMyFlight.airlineCompany?.airlineColor
        }
    }
}
