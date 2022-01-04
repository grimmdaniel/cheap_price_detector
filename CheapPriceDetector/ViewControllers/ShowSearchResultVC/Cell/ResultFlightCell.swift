//
//  ResultFlightCell.swift
//  CheapPriceDetector
//
//  Created by grimmdaniel on 2021. 07. 22..
//

import UIKit

class ResultFlightCell: UITableViewCell {
    
    static let cellID = "ResultFlightCell"
    
    @IBOutlet weak var cellBackgroundView: UIView!
    
    @IBOutlet weak var buyButtonBackgroundView: UIView!
    
    @IBOutlet weak var outboundRouteNameLabel: UILabel!
    @IBOutlet weak var returnRouteNameLabel: UILabel!
    
    @IBOutlet weak var outboundRouteValueLabel: UILabel!
    @IBOutlet weak var returnRouteValueLabel: UILabel!
    
    @IBOutlet weak var travellingPeriodNameLabel: UILabel!
    @IBOutlet weak var travellingPeriodValueLabel: UILabel!
    
    @IBOutlet weak var nightsLabel: UILabel!
    @IBOutlet weak var nightsValueLabel: UILabel!
    
    @IBOutlet weak var totalPriceNameLabel: UILabel!
    @IBOutlet weak var totalPriceValueLabel: UILabel!
    
    @IBOutlet weak var detailedPriceNameLabel: UILabel!
    @IBOutlet weak var detailedPriceValueLabel: UILabel!
    
    
    @IBOutlet weak var buyTicketButton: UIButton!
    
    var buySelectedFlightClosure: ((Flight) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
        cellBackgroundView.layer.cornerRadius = 8.0
        cellBackgroundView.clipsToBounds = true
        buyButtonBackgroundView.backgroundColor = ColorTheme.secondaryColor
        outboundRouteNameLabel.text = "showSearchResultVC_outbound_route".localized
        returnRouteNameLabel.text = "showSearchResultVC_return_route".localized
        travellingPeriodNameLabel.text = "showSearchResultVC_travelling_period".localized
        nightsLabel.text = "showSearchResultVC_number_of_nights".localized
        totalPriceNameLabel.text = "showSearchResultVC_total_price".localized
        detailedPriceNameLabel.text = "showSearchResultVC_detailed_price".localized
    }
    
    var currentFlight: Flight! {
        didSet {
            outboundRouteValueLabel.text = currentFlight.outboundRoute.replacingOccurrences(of: "/", with: " / ")
            returnRouteValueLabel.text = currentFlight.returnRoute.replacingOccurrences(of: "/", with: " / ")
            nightsValueLabel.text = "\(currentFlight.nights)"
            totalPriceValueLabel.text = currentFlight.totalPrice
            detailedPriceValueLabel.text = currentFlight.detailedPrice
            travellingPeriodValueLabel.text = currentFlight.formattedOutboundDate + " / " + currentFlight.formattedReturnDate
        }
    }

    @IBAction func buyTicketButtonPressed(_ sender: UIButton) {
        buySelectedFlightClosure?(currentFlight)
    }
}
