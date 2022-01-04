//
//  SelectFlightDelegate.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 18..
//

import Foundation

protocol SelectFlightDelegate: DownloadAble {
    
    func didFinishFetchinAllFlights(flights: [Flight])
}
