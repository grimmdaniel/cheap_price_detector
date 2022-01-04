//
//  SettingsCoordinator.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 17..
//

import UIKit

class SettingsCoordinator: Coordinator {
    
    private let navigationController = CustomUINavigationController()
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    override func start() {
        
        navigationController.delegate = self
        showSettingsScreen()
    }
    
    override func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        childCoordinators.forEach { (childCoordinator) in
            childCoordinator.navigationController(navigationController, willShow: viewController, animated: animated)
        }
    }
    
    override func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        childCoordinators.forEach { (childCoordinator) in
            childCoordinator.navigationController(navigationController, didShow: viewController, animated: animated)
        }
    }
    
    private func showSettingsScreen() {
        
        let selectFlightVC = MyFlightsVC.instantiate()
        
        //set service aand viewmodel here
        navigationController.pushViewController(selectFlightVC, animated: true)
    }
}
