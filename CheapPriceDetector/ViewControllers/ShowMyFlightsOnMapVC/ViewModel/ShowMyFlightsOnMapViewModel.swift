//
//  ShowMyFlightsOnMapViewModel.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 12. 26..
//

import Foundation
import UIKit
import CoreLocation

class ShowMyFlightsOnMapViewModel {
    
    private let _myFlights: [MyFlight]
    
    init(myFlights: [MyFlight]) {
        _myFlights = myFlights
    }
    
    var myFlights: [MyFlight] {
        return _myFlights
    }
    
    lazy var airportAnnotations: [AirportAnnotation] = {
        var uniqueAirports = Set<Airport>()
        _myFlights.forEach { flights in
            if let origin = flights.originAirport { uniqueAirports.insert(origin) }
            if let destination = flights.arrivingAirport { uniqueAirports.insert(destination) }
        }
        return uniqueAirports.compactMap { airport in
            guard let coordinate = airport.coordinate else { return nil }
            return AirportAnnotation(airport: airport, coordinate: coordinate)
        }
    }()
    
    func getLineData() -> [(CLLocationCoordinate2D,CLLocationCoordinate2D,UIColor)] {
        return _myFlights.compactMap { flight in
            guard let originCoord = flight.originAirport?.coordinate else { return nil }
            guard let destCoord = flight.arrivingAirport?.coordinate else { return nil }
            let color = flight.airlineCompany?.airlineColor ?? ColorTheme.primaryColor
            return (originCoord,destCoord,color)
        }
    }
}
