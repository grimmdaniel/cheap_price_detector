//
//  ChooseAirportsOnMapViewModel.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 08. 03..
//

import Foundation
import CoreLocation

class ChooseAirportsOnMapViewModel  {
    
    let routes: [Route]
    var airportPins: [AirportAnnotation]
    var currentOriginAirportSelected: Airport?
    var currentDestinationAirportSelected: Airport?
    
    init(routes: [Route]) {
        self.routes = routes
        airportPins = ChooseAirportsOnMapViewModel.convertRoutesToAirportAnnotations(routes: routes)
    }
    
    private static func convertRoutesToAirportAnnotations(routes: [Route]) -> [AirportAnnotation] {
        return routes.compactMap({ (route) -> AirportAnnotation? in
            guard let coordinate = route.originAirport.coordinate else { return nil }
            return AirportAnnotation(airport: route.originAirport, coordinate: coordinate)
        })
    }
    
    func getAllDestinationAirportCodes(to airport: Airport) -> Set<String> {
        let aps = routes.filter({ $0.originAirport == airport })
        if aps.isEmpty { return Set<String>() }
        var destinationCodes = Set<String>(aps[0].destinationAirports.map({$0.iataCode}))
        destinationCodes.insert(airport.iataCode)
        return destinationCodes
    }
    
    func deselectAllAnnotations() {
        airportPins.forEach({ $0.isSelected = false })
    }
    
    private func getRouteDistance() -> Int {
        guard let originAirportLocationCoord = currentOriginAirportSelected?.coordinate else { return 0 }
        let originLocation = CLLocation(latitude: originAirportLocationCoord.latitude, longitude: originAirportLocationCoord.longitude)
        guard let destinationAirportLocationCooord = currentDestinationAirportSelected?.coordinate else { return 0 }
        let destinationLocation = CLLocation(latitude: destinationAirportLocationCooord.latitude, longitude: destinationAirportLocationCooord.longitude)
        return Int(originLocation.distance(from: destinationLocation) / 1000)
    }
    
    func getRouteDistanceText() -> String {
        return "\(currentOriginAirportSelected?.iataCode ?? "N/A")-\(currentDestinationAirportSelected?.iataCode ?? "N/A") (\(getRouteDistance()) km)"
    }
    
    
}
