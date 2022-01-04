//
//  Endpoints.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 17..
//

import Foundation

enum Endpoints: String {
    
    static let BASE_URL = "http://192.168.0.17:8000/api/v1"
    case destinations = "/destinations/"
    case flights = "/flights/"
    case routes = "/routes/"
}
