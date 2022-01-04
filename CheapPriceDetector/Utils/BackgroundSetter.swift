//
//  BackgroundSetter.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 08. 06..
//

import UIKit

class BackgroundSetter {
    
    public static let defaultSetter = BackgroundSetter()
    
    private init() {}
    
    private let iphoneBackground = UIImage(named: "background") ?? UIImage()
    private let ipadBackground = UIImage(named: "background_ipad") ?? UIImage()
    
    func getBackgroundImage() -> UIImage {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return ipadBackground
        } else {
            return iphoneBackground
        }
    }
}
