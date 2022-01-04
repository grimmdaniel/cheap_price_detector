//
//  ResponseParser.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 20..
//

import Foundation
import CoreLocation

class ResponseParser {
    
    private init() {}
    
    static let shared = ResponseParser()
    
    func parseAllRoutes(json: [String:Any]) -> [Route] {
        if let jsonArray = json["routes"] as? [[String:Any]] {
            var routes = [Route]()
            for jsonElement in jsonArray {
                if let iataCode = jsonElement["iata_code"] as? String {
                    if let airportName = jsonElement["origin"] as? String {
                        let latitude = jsonElement["latitude"] as? Double ?? 0.0
                        let longitude = jsonElement["longitude"] as? Double ?? 0.0
                        let coordinate = Coordinate(latitude: latitude, longitude: longitude)
                        var destinations = [Airport]()
                        if let destinationsRaw = jsonElement["destinations"] as? [[String:Any]] {
                            for airportJson in destinationsRaw {
                                if let destCode = airportJson["iata_code"] as? String {
                                    if let destAirportName = airportJson["destination"] as? String {
                                        destinations.append(Airport(airportName: destAirportName, iataCode: destCode, coordinate: nil))
                                    }
                                }
                            }
                        }
                        routes.append(Route(originAirport: Airport(airportName: airportName, iataCode: iataCode, coordinate: coordinate), destinationAirports: destinations))
                    }
                }
            }
            return routes
        }
        return []
    }
    
    func parseAllFlights(json: [String:Any]) -> [Flight] {
        if let jsonArray = json["flights"] as? [[String:Any]] {
            guard let data = try? JSONSerialization.data(withJSONObject: jsonArray, options: .prettyPrinted) else { return [] }
            return (try? JSONDecoder().decode([Flight].self, from: data)) ?? []
        }
        return []
    }
    
//    func parseAllFlights(json: [String:Any]) -> [Flight] {
//        if let jsonArray = json["flights"] as? [[String:Any]] {
//            var flights = [Flight]()
//            for jsonElement in jsonArray {
//                if let outboundRoute = jsonElement["Origin_airport"] as? String {
//                    if let returnRoute = jsonElement["Destination_airport"] as? String {
//                        if let departureDate = jsonElement["Departure_date"] as? String {
//                            if let returnDate = jsonElement["Departure_date2"] as? String {
//                                if let nights = jsonElement["nights"] as? Int {
//                                    if let price = jsonElement["total_price"] as? String {
//                                        if let detailedPrice = jsonElement["Price_detailed"] as? String {
//                                            flights.append(Flight(outboundRoute: outboundRoute, returnRoute: returnRoute, departureDate: departureDate, returnDate: returnDate, nights: nights, totalPrice: price, detailedPrice: detailedPrice))
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            return flights
//        }
//        return []
//    }
}
