//
//  NightSelectCell.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 30..
//

import UIKit
import MultiSlider

class NightSelectCell: UITableViewCell {
    
    static let cellID = "NightSelectCell"
    
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var sliderView: MultiSlider!
    @IBOutlet weak var selectNightsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
        cellBackgroundView.layer.cornerRadius = 8.0
        cellBackgroundView.clipsToBounds = true
        
        sliderView.minimumValue = 1
        sliderView.maximumValue = 14
        sliderView.isContinuous = false
        sliderView.isVertical = false
        sliderView.valueLabelPosition = .top
        sliderView.snapStepSize = 1
        sliderView.tintColor = ColorTheme.primaryColor
        sliderView.trackWidth = 10
        
        selectNightsLabel.text = "selectFlightVC_number_of_nights".localized
    }
    
    var currentNights: (Int,Int)! {
        didSet {
            sliderView.value = [CGFloat(currentNights.0),CGFloat(currentNights.1)]
        }
    }
}
