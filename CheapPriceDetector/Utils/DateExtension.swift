//
//  DateExtension.swift
//  CheapPriceDetector
//
//  Created by grimmdaniel on 2021. 07. 12..
//

import Foundation

extension Date {
    
    func wizzDateFormat() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df.string(from: self)
    }
}
