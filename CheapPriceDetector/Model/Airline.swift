//
//  Airline.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 08. 13..
//

import UIKit

struct Airline: Codable {

    let name: String
    let abbreviation: String
    private let _airlineColor: String // hex

    internal init(name: String, abbreviation: String, airlineColor: String) {
        self.name = name
        self.abbreviation = abbreviation
        self._airlineColor = airlineColor
    }

    var airlineColor: UIColor {
        return UIColor.hexStringToUIColor(hexCode: _airlineColor)
    }
}
