//
//  SelectAirportViewModel.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 28..
//

import Foundation

class SelectAirportViewModel {
    
    let airports: [Airport]
    var searchedAirports = [Airport]()
    
    init(airports: [Airport]) {
        self.airports = airports.sorted(by: { (lhs, rhs) -> Bool in
            lhs.airportName < rhs.airportName
        })
    }
    
    var numberOfRowsInSection: Int {
        return 1
    }
    
    func numberOfSections(searching: Bool) -> Int {
        return searching ? searchedAirports.count : airports.count
    }
    
    func getAirport(for index: Int, searching: Bool) -> Airport {
        return searching ? searchedAirports[index] : airports[index]
    }
    
    func searchAirports(_ searchText: String) {
        searchedAirports = airports.filter { (airport: Airport) -> Bool in
            let lowercased = searchText.lowercased()
            return airport.airportName.lowercased().contains(lowercased) || airport.iataCode.lowercased().contains(lowercased)
        }
        searchedAirports = searchedAirports.sorted(by: { (lhs, rhs) -> Bool in
            lhs.airportName < rhs.airportName
        })
    }
}
