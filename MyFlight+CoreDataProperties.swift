//
//  MyFlight+CoreDataProperties.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 08. 19..
//
//

import Foundation
import CoreData


extension MyFlight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyFlight> {
        return NSFetchRequest<MyFlight>(entityName: "MyFlight")
    }

    @NSManaged public var date: Date
    @NSManaged public var flightNumber: String?

}

extension MyFlight : Identifiable {

}
