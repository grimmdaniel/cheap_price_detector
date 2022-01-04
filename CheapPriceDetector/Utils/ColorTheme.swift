//
//  ColorTheme.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 20..
//

import UIKit

class ColorTheme {
    
    static let secondaryColor: UIColor = UIColor.hexStringToUIColor(hexCode: "072c50")
    static let primaryColor: UIColor = UIColor.hexStringToUIColor(hexCode: "cc313d")
    
}

extension UIColor {
    
    static func hexStringToUIColor (hexCode: String) -> UIColor {
        var colorString:String = hexCode.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (colorString.hasPrefix("#")) {
            colorString.remove(at: colorString.startIndex)
        }
        
        if (colorString.count != 6) {
            return UIColor.gray
        }
                
        var rgbValue:UInt64 = 0
        Scanner(string: colorString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
