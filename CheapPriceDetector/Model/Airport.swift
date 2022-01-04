//
//  Airport.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 18..
//

import Foundation
import CoreLocation

struct Airport: Codable {

    let id: String
    let airportName: String
    let iataCode: String
    private let _coordinate: Coordinate?

    var coordinate: CLLocationCoordinate2D? {
        guard let lat = _coordinate?.latitude, let lon = _coordinate?.longitude else { return nil }
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }

    enum CodingKeys: String, CodingKey {
        case id, airportName, iataCode, _coordinate = "coordinate"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(airportName, forKey: .airportName)
        try container.encode(iataCode, forKey: .iataCode)
        try container.encode(_coordinate, forKey: ._coordinate)
    }

    init(airportName: String, iataCode: String, coordinate: Coordinate?) {
        self.id = UUID().uuidString
        self.airportName = airportName
        self.iataCode = iataCode
        self._coordinate = coordinate
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        airportName = try container.decode(String.self, forKey: .airportName)
        iataCode = try container.decode(String.self, forKey: .iataCode)
        _coordinate = try container.decode(Coordinate.self, forKey: ._coordinate)
    }
}

extension Airport: Equatable, Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(airportName+iataCode)
    }

    static func ==(lhs: Airport, rhs: Airport) -> Bool {
        return lhs.airportName == rhs.airportName && lhs.iataCode == rhs.iataCode
    }
}
