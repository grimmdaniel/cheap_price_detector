//
//  Flight.swift
//  CheapPriceDetector
//
//  Created by grimmdaniel on 2021. 07. 12..
//

import Foundation

struct Flight: Codable {
    
    let outboundRoute: String
    let returnRoute: String
    let departureDate: String
    let returnDate: String
    let nights: Int
    let totalPrice: String
    let detailedPrice: String
    
    private enum CodingKeys: String, CodingKey {
        case outboundRoute = "Origin_airport"
        case returnRoute = "Destination_airport"
        case departureDate = "Departure_date"
        case returnDate = "Departure_date2"
        case nights = "nights"
        case totalPrice = "total_price"
        case detailedPrice = "Price_detailed"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        outboundRoute = try container.decode(String.self, forKey: .outboundRoute)
        returnRoute = try container.decode(String.self, forKey: .returnRoute)
        departureDate = try container.decode(String.self, forKey: .departureDate)
        returnDate = try container.decode(String.self, forKey: .returnDate)
        nights = try container.decode(Int.self, forKey: .nights)
        totalPrice = try container.decode(String.self, forKey: .totalPrice)
        detailedPrice = try container.decode(String.self, forKey: .detailedPrice)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(outboundRoute, forKey: .outboundRoute)
        try container.encode(returnRoute, forKey: .returnRoute)
        try container.encode(departureDate, forKey: .departureDate)
        try container.encode(returnDate, forKey: .returnDate)
        try container.encode(nights, forKey: .nights)
        try container.encode(totalPrice, forKey: .totalPrice)
        try container.encode(detailedPrice, forKey: .detailedPrice)
    }
    
    var formattedOutboundDate: String {
        return formatDateTime(date: departureDate)
    }
    
    var formattedReturnDate: String {
        return formatDateTime(date: returnDate)
    }
    
    var priceAmount: Double {
        let splittedPrice = totalPrice.components(separatedBy: " ")
        if splittedPrice.count != 2 { return 0.0 }
        return Double(splittedPrice[0]) ?? 0.0
    }
    
    private func formatDateTime(date: String) -> String {
        let splittedDate = date.components(separatedBy: " - ")
        if splittedDate.count != 2 { return date }
        return splittedDate[0].replacingOccurrences(of: "-", with: ". ") + ". - " + splittedDate[1]
    }
}
