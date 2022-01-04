//
//  SelectAirlineDelegate.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 09. 24..
//

import UIKit

class SelectAirlineDelegate: NSObject, UITableViewDelegate {
    
    weak var parentVC: SelectAirlineVC?
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        parentVC?.selectAirline(index: indexPath.section)
    }
}

