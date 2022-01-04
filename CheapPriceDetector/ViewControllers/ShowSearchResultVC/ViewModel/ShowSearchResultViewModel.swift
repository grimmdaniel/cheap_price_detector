//
//  ShowSearchResultViewModel.swift
//  CheapPriceDetector
//
//  Created by grimmdaniel on 2021. 07. 12..
//

import Foundation

class ShowSearchResultViewModel {
    
    var flights: [Flight]
    
    init(flights: [Flight]) {
        self.flights = flights
    }
    
    var numberOfRowsInSection: Int {
        return 1
    }
    
    var numberOfSections: Int {
        return flights.count
    }
    
    func getFlight(for index: Int) -> Flight {
        return flights[index]
    }
    
    func createFlightBookingURL(flight: Flight) -> String {
        let depDate = flight.departureDate.components(separatedBy: " - ")[0]
        let retDate = flight.returnDate.components(separatedBy: " - ")[0]
        let route = flight.outboundRoute.components(separatedBy: "/")
        let preferredLang = "showSearchResultVC_wizz_site_lan".localized
        //Example https://wizzair.com/hu-hu#/booking/select-flight/BUD/LIS/2021-07-28/2021-08-02/1/0/0/null
        return "https://wizzair.com/\(preferredLang)#/booking/select-flight/\(route[0])/\(route[1])/\(depDate)/\(retDate)/1/0/0/null"
    }
    
    func sortFlights(by predicate: SortSearchResultType) {
        let sorter: ((Flight,Flight) -> Bool)
        switch predicate {
        
        case .priceAscending:
            sorter = { $0.priceAmount < $1.priceAmount }
        case .priceDescending:
            sorter = { $0.priceAmount > $1.priceAmount }
        case .nightsAscending:
            sorter = { (lhs: Flight, rhs: Flight) in
                if lhs.nights != rhs.nights {
                    return lhs.nights < rhs.nights
                }
                return lhs.priceAmount < rhs.priceAmount
            }
        case .nightsDescending:
            sorter = { (lhs: Flight, rhs: Flight) in
                if lhs.nights != rhs.nights {
                    return lhs.nights > rhs.nights
                }
                return lhs.priceAmount < rhs.priceAmount
            }
        case .earliestDate:
            sorter = { (lhs: Flight, rhs: Flight) in
                if lhs.departureDate != rhs.departureDate {
                    return lhs.departureDate < rhs.departureDate
                }
                return lhs.priceAmount < rhs.priceAmount
            }
        case .latestDate:
            sorter = { (lhs: Flight, rhs: Flight) in
                if lhs.departureDate != rhs.departureDate {
                    return lhs.departureDate > rhs.departureDate
                }
                return lhs.priceAmount < rhs.priceAmount
            }
        }
        flights = flights.sorted(by: sorter)
    }
    
    enum SortSearchResultType {
        
        case priceAscending, priceDescending, nightsAscending, nightsDescending, earliestDate, latestDate
    }
}


