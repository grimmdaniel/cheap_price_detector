//
//  SelectFlightService.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 18..
//

import Foundation

class SelectFlightService {
    
    weak var flightDelegate: SelectFlightDelegate?
    weak var routeDelegate: SelectRouteDelegate?
    
    func fetchRoutes() {
        let httpHeader = ["Content-Type": "application/json"]
        let httpObject = HTTPObject(type: .GET, endpoint: .routes, httpHeader: httpHeader)
        routeDelegate?.didStartFetchingData()
        NetworkManager().performNetworkRequest(with: httpObject) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    let routes = ResponseParser.shared.parseAllRoutes(json: json)
                    self?.routeDelegate?.didFinishFetchingRoutes(routes: routes)
                case .failure(let error):
                    self?.routeDelegate?.didFailFetchingData(error: error)
                }
            }
        }
    }
    
    func fetchFlight(params: [String:String]) {
        let httpHeader = ["Content-Type": "application/json"]
        let httpObject = HTTPObject(type: .GET, endpoint: .flights, urlParameters: params, httpHeader: httpHeader)
        flightDelegate?.didStartFetchingData()
        NetworkManager().performNetworkRequest(with: httpObject) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    let flights = ResponseParser.shared.parseAllFlights(json: json)
                    self?.flightDelegate?.didFinishFetchinAllFlights(flights: flights)
                case .failure(let error):
                    self?.flightDelegate?.didFailFetchingData(error: error)
                }
            }
        }
    }
}
