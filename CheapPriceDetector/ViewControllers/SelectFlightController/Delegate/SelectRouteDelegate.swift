//
//  SelectRouteDelegate.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 08. 17..
//

import Foundation

protocol SelectRouteDelegate: DownloadAble {
    func didFinishFetchingRoutes(routes: [Route])
}
