//
//  SelectAirlineCell.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 09. 24..
//

import UIKit

class SelectAirlineCell: UITableViewCell {
    
    static let cellID = "SelectAirlineCell"
    
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var airlineNameLabel: UILabel!
    @IBOutlet weak var airlineAbbrLabel: UILabel!
    @IBOutlet weak var airlineColorView: UIView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var currentAirline: Airline! {
        didSet {
            airlineNameLabel.text = currentAirline.name
            airlineAbbrLabel.text = currentAirline.abbreviation
            airlineColorView.backgroundColor = currentAirline.airlineColor
            airlineColorView.layer.borderWidth = 2
            airlineColorView.layer.borderColor = UIColor.lightGray.cgColor
            airlineColorView.layer.cornerRadius = 5.0
            airlineColorView.clipsToBounds = true
        }
    }
}
