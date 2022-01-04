//
//  CustomUINavigationController.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 12. 31..
//

import UIKit

class CustomUINavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = ColorTheme.primaryColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.tintColor = .white
    }
}
