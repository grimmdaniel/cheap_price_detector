//
//  SelectAirlineViewModel.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 09. 24..
//

import Foundation

class SelectAirlineViewModel {
    
    private let airlines = [
        Airline(name: "Tap Portugal", abbreviation: "TP", airlineColor: "#83bb56"),
        Airline(name: "Wizz Air", abbreviation: "W6", airlineColor: "#b5257b"),
        Airline(name: "RyanAir", abbreviation: "FR", airlineColor: "#17348a"),
        Airline(name: "Norwegian Air Shuttle", abbreviation: "DY", airlineColor: "#c72f3d"),
        Airline(name: "Vueling Airlines", abbreviation: "VY", airlineColor: "#f6ce46"),
        Airline(name: "EasyJet", abbreviation: "EC", airlineColor: "#ef712c")
    ]
    
    var numberOfRowsInSection: Int {
        return 1
    }
    
    var numberOfSections: Int {
        return airlines.count
    }
    
    func getAirline(for index: Int) -> Airline {
        return airlines[index]
    }
}
