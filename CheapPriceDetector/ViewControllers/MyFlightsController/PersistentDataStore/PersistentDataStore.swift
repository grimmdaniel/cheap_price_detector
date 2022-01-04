//
//  PersistentDataStore.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 08. 19..
//

import Foundation
import CoreData

class PersistentDataStore: PersistableFlight {

    var managedObjectContext: NSManagedObjectContext!

    private lazy var persistentContainer: NSPersistentContainer = {
        NSPersistentContainer(name: "MyFlights")
    }()

    init() {
        persistentContainer.loadPersistentStores { [weak self] persistentStoreDescription, error in
                if let error = error {
                    print("Unable to Add Persistent Store")
                    print("\(error), \(error.localizedDescription)")

                } else {
                    self?.readItems(completed: { (flights) in
                        print(flights)
                    })
                }
            }
    }

    func persist(item: [String:Any]) -> MyFlight? {
        managedObjectContext = persistentContainer.viewContext
        let flight = MyFlight(context: managedObjectContext)
        flight.setAirlineCompany(from: item["airline"] as! Airline)
        flight.setOriginAirport(from: item["origin"] as! Airport)
        flight.setArrivingAirport(from: item["destination"] as! Airport)
        flight.date = item["date"] as! Date
        flight.flightNumber = item["flightNumber"] as? String
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Unable to Save Flight, \(error)")
            return nil
        }
        return flight
    }

    func readItems(completed: @escaping (([MyFlight]) -> Void)){
        let fetchRequest: NSFetchRequest<MyFlight> = MyFlight.fetchRequest()

        persistentContainer.viewContext.perform {
            do {
                // Execute Fetch Request
                let result = try fetchRequest.execute()
                completed(result)
            } catch {
                print("Unable to Execute Fetch Request, \(error)")
            }
        }
    }

    func delete(item: MyFlight) {
        persistentContainer.viewContext.delete(item)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Unable to delete flight, \(error)")
        }
    }

}
