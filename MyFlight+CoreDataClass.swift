//
//  MyFlight+CoreDataClass.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 08. 19..
//
//

import Foundation
import CoreData

@objc(MyFlight)
public class MyFlight: NSManagedObject {

    @NSManaged private var departureAirport: String?
    @NSManaged private var destinationAirport: String?
    @NSManaged private var airline: String?

    var originAirport: Airport? {
        let airport: Airport? = self.departureAirport?.decodeFromJSON()
        return airport
    }

    var arrivingAirport: Airport? {
        let airport: Airport? = self.destinationAirport?.decodeFromJSON()
        return airport
    }

    var airlineCompany: Airline? {
        let airl: Airline? = self.airline?.decodeFromJSON()
        return airl
    }

    func setOriginAirport(from airport: Airport) {
        self.departureAirport = airport.encodeToJSON()
    }

    func setArrivingAirport(from airport: Airport) {
        self.destinationAirport = airport.encodeToJSON()
    }

    func setAirlineCompany(from airline: Airline) {
        self.airline = airline.encodeToJSON()
    }
}
