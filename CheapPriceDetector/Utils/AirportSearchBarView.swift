//
//  AirportSearchBarView.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 08. 02..
//

import UIKit

class AirportSearchBarView: UISearchController {
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        customizeSearchController()
    }
    
    init() {
        super.init(searchResultsController: nil)
        customizeSearchController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customizeSearchController()
    }
    
    var isSearchBarEmpty: Bool {
      return searchBar.text?.isEmpty ?? true
    }
    
    private func customizeSearchController() {
        hidesNavigationBarDuringPresentation = false
        searchBar.tintColor = .white
        searchBar.searchBarStyle = .prominent
        searchBar.searchTextField.backgroundColor = ColorTheme.primaryColor
        searchBar.searchTextField.leftView?.tintColor = .white
        obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "chooseAirportVC_vc_search_placeholder".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}
