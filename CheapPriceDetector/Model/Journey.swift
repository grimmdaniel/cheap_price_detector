//
//  Journey.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 23..
//

import Foundation

struct Journey {
    
    var originAirport: Airport?
    var destinationAirport: Airport?
    
    var departureDate = Date()
    var returnDate = Calendar.current.date(byAdding: .day, value: 60, to: Date())!
    var minNights = 1
    var maxNights = 4
    
    var formattedDepartureDate: String {
        return departureDate.wizzDateFormat()
    }
    
    var formattedReturnDate: String {
        return returnDate.wizzDateFormat()
    }
}
