//
//  SelectFlightViewModel.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 20..
//

import Foundation

class SelectFlightViewModel {
    
    private var routes = [Route]()
    private var currentRoute = Journey()
    
    func getAllRoutes() -> [Route] {
        return routes
    }
    
    func refreshDataSource(routes: [Route]) {
        self.routes = routes
    }
    
    func getCurrentOrigin() -> Airport? {
        return currentRoute.originAirport
    }
    
    func getCurrentDestination() -> Airport? {
        return currentRoute.destinationAirport
    }
    
    func getAllOriginAirports() -> [Airport] {
        return routes.map({$0.originAirport})
    }
    
    func getAllDestinationAirports(to airport: Airport) -> [Airport] {
        let aps = routes.filter({ $0.originAirport == airport })
        if aps.isEmpty { return [] }
        return aps[0].destinationAirports
    }
    
    func selectNewOriginAirport(new airport: Airport) {
        currentRoute.originAirport = airport
    }
    
    func selectNewDestinationAirport(new airport: Airport) {
        currentRoute.destinationAirport = airport
    }
    
    func selectNewEarliestDate(new date: Date) {
        currentRoute.departureDate = date
    }
    
    func selectNewLatestDate(new date: Date) {
        currentRoute.returnDate = date
    }
    
    func getCurrentEarliestDate() -> Date {
        return currentRoute.departureDate
    }
    
    func changeOriginWithDestination() {
        let temp = currentRoute.originAirport
        currentRoute.originAirport = currentRoute.destinationAirport
        currentRoute.destinationAirport = temp
    }
    
    func printCurrentJourney() {
        print("\(currentRoute.originAirport?.airportName ?? "???") -> \(currentRoute.destinationAirport?.airportName ?? "???")")
    }
    
    var currentJourney: Journey {
        return currentRoute
    }
    
    func resetJourney() {
        currentRoute = Journey()
    }
    
    func removeDestination() {
        currentRoute.destinationAirport = nil
    }
    
    func updateNumberOfNights(minN: Int, maxN: Int) {
        currentRoute.minNights = minN
        currentRoute.maxNights = maxN
    }
    
    func getNumberOfNights() -> (Int,Int) {
        return (currentRoute.minNights, currentRoute.maxNights)
    }
    
    func generateSearchData() -> [String:String]? {
        guard let origin = currentRoute.originAirport, let destination = currentRoute.destinationAirport else  {
            return nil
        }
        return [
            "oap": origin.iataCode,
            "dap": destination.iataCode,
            "mins": String(currentRoute.minNights),
            "maxs": String(currentRoute.maxNights),
            "edate": currentRoute.formattedDepartureDate,
            "ldate": currentRoute.formattedReturnDate,
            "wdc":"0"
        ]
    }
}
