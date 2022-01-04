//
//  Extensions_Encodable.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 08. 19..
//

import Foundation

extension Encodable {

    func encodeToJSON() -> String? {
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(self) else { return nil }
        return String(data: jsonData, encoding: String.Encoding.utf8)
    }
}
