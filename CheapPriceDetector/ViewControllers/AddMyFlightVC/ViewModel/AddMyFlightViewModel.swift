//
//  AddMyFlightViewModel.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 09. 05..
//

import Foundation

class AddMyFlightViewModel {

    public private(set) var flightDate: Date?
    public private(set) var originAirport: Airport?
    public private(set) var destinationAirport: Airport?
    public private(set) var airline: Airline?
    public private(set) var flightNumber: String?
    
    let routes: [Route]

    init(routes: [Route]) {
        self.routes = routes
    }

    func saveDate(date: Date) {
        self.flightDate = date
    }

    func saveAirports(origin: Airport, destination: Airport) {
        self.originAirport = origin
        self.destinationAirport = destination
    }
    
    func saveAirline(airline: Airline) {
        self.airline = airline
    }
    
    func saveFlightNumber(flightNumber: String) {
        self.flightNumber = flightNumber
    }

    func generateMyFlightRawData() -> [String:Any] {
        let flight = [
            "destination": destinationAirport as Any,
            "origin": originAirport as Any,
            "airline": airline as Any,
            "date": flightDate ?? Date(),
            "flightNumber": flightNumber ?? ""
        ] as [String : Any]
        return flight
    }
    
    func changeAirports() {
        if originAirport == nil || destinationAirport == nil { return }
        swap(&originAirport, &destinationAirport)
    }
    
    func isItFullyCompleted() -> Bool {
        return originAirport != nil && destinationAirport != nil && airline != nil
    }
}
