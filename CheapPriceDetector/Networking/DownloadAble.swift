//
//  DownloadAble.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 08. 17..
//

import Foundation

protocol DownloadAble: AnyObject {
    
    func didStartFetchingData()
    func didFailFetchingData(error: NetworkError)
}
