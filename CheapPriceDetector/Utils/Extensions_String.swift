//
//  Extensions_String.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 08. 02..
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension String {

    func decodeFromJSON<T: Decodable>() -> T? {
        guard let resultData = self.data(using: String.Encoding.utf8) else { return nil }
        let jsonDecoder = JSONDecoder()
        return try? jsonDecoder.decode(T.self, from: resultData)
    }
}
