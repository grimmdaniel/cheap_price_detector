//
//  AirportAnnotation.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 08. 03..
//

import UIKit
import MapKit

class AirportAnnotation: MKPointAnnotation {
    
    let airport: Airport
    let image: UIImage
    var isSelected: Bool = false
    
    init(airport: Airport, coordinate: CLLocationCoordinate2D) {
        self.airport = airport
        self.image = AirportAnnotation.resizeImage(image: UIImage(named: "location.png")!)
        super.init()
        self.title = "\(airport.airportName) (\(airport.iataCode))" 
        self.coordinate = coordinate
    }
    
    private static func resizeImage(image: UIImage) -> UIImage {
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        return resizedImage ?? UIImage()
    }
}
