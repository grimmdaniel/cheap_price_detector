//
//  Persistable.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 08. 19..
//

import Foundation

protocol PersistableFlight {

    func persist(item: [String:Any]) -> MyFlight?
    func readItems(completed: @escaping ([MyFlight]) -> Void)
    func delete(item: MyFlight)
}
