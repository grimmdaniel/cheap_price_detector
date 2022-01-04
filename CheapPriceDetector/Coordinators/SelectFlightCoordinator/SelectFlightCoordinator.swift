//
//  SelectFlightCoordinator.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 17..
//

import UIKit

class SelectFlightCoordinator: Coordinator {
    
    private let navigationController = CustomUINavigationController()
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    override func start() {
        
        navigationController.delegate = self
        showSelectFlightScreen()
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
    
    private func showSelectFlightScreen() {
        
        let selectFlightVC = SelectFlightController.instantiate()
        
        selectFlightVC.service = SelectFlightService()
        selectFlightVC.tableViewdelegate = FlightFormTableViewDelegate()
        selectFlightVC.tableViewDataSource = FlightFormTableViewDataSource(viewModel: SelectFlightViewModel())
        
        selectFlightVC.showMyFlightsScreenClosure = { [weak self] (routes) in
            guard let showProfileVC = self?.showMyFlightsScreen(routes: routes) else { return }
            self?.navigationController.pushViewController(showProfileVC, animated: true)
        }
        
        selectFlightVC.selectAirportClosure = { [weak self] (airports,flag) in
            guard let selectAirportVC = self?.showSelectAirportVC(airports: airports, flag: flag) else { return }
            selectAirportVC.airportClosure = { [weak self] (airport) in
                if flag {
                    selectFlightVC.tableViewDataSource.viewModel.selectNewOriginAirport(new: airport)
                    selectFlightVC.tableViewDataSource.viewModel.removeDestination()
                } else {
                    selectFlightVC.tableViewDataSource.viewModel.selectNewDestinationAirport(new: airport)
                }
                selectFlightVC.refreshData()
                self?.navigationController.popViewController(animated: true)
            }
            self?.navigationController.pushViewController(selectAirportVC, animated: true)
        }
        
        selectFlightVC.selectAirportOnMapClosure = { [weak self] (routes) in
            guard let chooseAirportsOnMapVC = self?.showSelectAirportOnMapVC(routes: routes) else { return }
            chooseAirportsOnMapVC.selectedAirportsClosure = { [weak self] (origin,destination) in
                selectFlightVC.tableViewDataSource.viewModel.selectNewOriginAirport(new: origin)
                selectFlightVC.tableViewDataSource.viewModel.selectNewDestinationAirport(new: destination)
                selectFlightVC.refreshData()
                self?.navigationController.popViewController(animated: true)
            }
            self?.navigationController.pushViewController(chooseAirportsOnMapVC, animated: true)
        }
        
        selectFlightVC.selectDateClosure = { [weak self] (dateType) in
            guard let selectDateVC = self?.showSelectDateVC() else { return }
            selectDateVC.minimumDate = dateType == .earliestDate ? Date() : selectFlightVC.tableViewDataSource.viewModel.getCurrentEarliestDate()
            selectDateVC.selectDateClosure = { (newDate) in
                switch dateType {
                case .earliestDate:
                    selectFlightVC.tableViewDataSource.viewModel.selectNewEarliestDate(new: newDate)
                case .latestDate:
                    selectFlightVC.tableViewDataSource.viewModel.selectNewLatestDate(new: newDate)
                }
                selectFlightVC.refreshData()
            }
            
            selectFlightVC.present(selectDateVC, animated: true, completion: nil)
        }
        
        selectFlightVC.showSearchResultClosure = { [weak self] (flights) in
            guard let searchResultVC = self?.showSearchResultsVC(flights: flights) else { return }
            self?.navigationController.pushViewController(searchResultVC, animated: true)
        }
        
        navigationController.pushViewController(selectFlightVC, animated: true)
    }
    
    private func showMyFlightsScreen(routes: [Route]) -> MyFlightsVC {
        let myFlightsVC = MyFlightsVC.instantiate()
        myFlightsVC.tableViewDelegate = MyFlightTableViewDelegate()
        myFlightsVC.tableViewDataSource = MyFlightsTableViewDataSource(with: PersistentDataStore())
        myFlightsVC.addNewFlightClosure = { [weak self] in
            guard let addFlightVC = self?.showAddMyFlightVC(routes: routes) else { return }
            addFlightVC.saveNewFlightClosure = { (myFlightRaw) in
                myFlightsVC.tableViewDataSource.saveElement(flightRaw: myFlightRaw)
            }
            myFlightsVC.present(addFlightVC, animated: true, completion: nil)
        }
        myFlightsVC.showFlightsOnMapClosure = { [weak self] (myFlights) in
            guard let showMyFlightsOnMapVC = self?.showShowMyFlightsOnMapVC(myFlights: myFlights) else { return }
            showMyFlightsOnMapVC.viewModel = ShowMyFlightsOnMapViewModel(myFlights: myFlights)
            self?.navigationController.pushViewController(showMyFlightsOnMapVC, animated: true)
        }
        return myFlightsVC
    }
    
    private func showSelectAirportVC(airports: [Airport], flag: Bool) -> ChooseAirportVC {
        let selectAirportVC = ChooseAirportVC.instantiate()
        let selectAirportViewModel = SelectAirportViewModel(airports: airports)
        selectAirportVC.selectAirportTableViewDataSource = SelectAirportTableViewDataSource(viewModel: selectAirportViewModel)
        return selectAirportVC
    }
    
    private func showShowMyFlightsOnMapVC(myFlights: [MyFlight]) -> ShowMyFlightsOnMapVC {
        let showMyFlightsOnMapVC = ShowMyFlightsOnMapVC.instantiate()
        return showMyFlightsOnMapVC
    }
    
    private func showSelectAirportOnMapVC(routes: [Route]) -> ChooseAirportsOnMapVC {
        let chooseAirportsOnMapVC = ChooseAirportsOnMapVC.instantiate()
        let chooseAirportsOnMapViewModel = ChooseAirportsOnMapViewModel(routes: routes)
        chooseAirportsOnMapVC.viewModel = chooseAirportsOnMapViewModel
        chooseAirportsOnMapVC.modalPresentationStyle = .fullScreen
        return chooseAirportsOnMapVC
    }
    
    private func showSelectDateVC() -> SelectDateVC {
        let selectDateVC = SelectDateVC.instantiate()
        selectDateVC.modalPresentationStyle = .formSheet
        return selectDateVC
    }
    
    private func showSelectAirlineVC() -> SelectAirlineVC {
        let selectAirlineVC = SelectAirlineVC.instantiate()
        selectAirlineVC.modalPresentationStyle = .fullScreen
        let selectAirlineViewModel = SelectAirlineViewModel()
        selectAirlineVC.selectAirlineDataSource = SelectAirlineDataSource(viewModel: selectAirlineViewModel)
        selectAirlineVC.selectAirlineDelegate = SelectAirlineDelegate()
        return selectAirlineVC
    }
    
    private func showSearchResultsVC(flights: [Flight]) -> ShowSearchResultVC {
        let searchResultVC = ShowSearchResultVC.instantiate()
        let showSearchResultViewModel = ShowSearchResultViewModel(flights: flights)
        searchResultVC.showFlightsTableViewDataSource = ShowFlightsTableViewDataSource(viewModel: showSearchResultViewModel)
        searchResultVC.showFlightsTableViewDelegate = ShowFlightsTableViewDelegate()
        return searchResultVC
    }

    private func showAddMyFlightVC(routes: [Route]) -> AddMyFlightVC {
        let addMyFlightVC = AddMyFlightVC.instantiate()
        addMyFlightVC.modalPresentationStyle = .formSheet
        addMyFlightVC.viewModel = AddMyFlightViewModel(routes: routes)

        addMyFlightVC.selectDateClosure = { [weak self] in
            guard let selectDateVC = self?.showSelectDateVC() else { return }
            selectDateVC.selectDateClosure = { (newDate) in
                addMyFlightVC.viewModel.saveDate(date: newDate)
                addMyFlightVC.refreshUI()
            }
            addMyFlightVC.present(selectDateVC, animated: true, completion: nil)
        }

        addMyFlightVC.selectAirportOnMapClosure = { [weak self] (routes) in
            guard let chooseAirportsOnMapVC = self?.showSelectAirportOnMapVC(routes: routes) else { return }
            chooseAirportsOnMapVC.selectedAirportsClosure = { (origin,destination) in
                addMyFlightVC.viewModel.saveAirports(origin: origin, destination: destination)
                addMyFlightVC.refreshUI()
                addMyFlightVC.dismiss(animated: true, completion: nil)
            }
            let tempNavVC = CustomUINavigationController(rootViewController: chooseAirportsOnMapVC)
            addMyFlightVC.present(tempNavVC, animated: true, completion: nil)
        }
        
        addMyFlightVC.selectAirlineClosure = { [weak self] in
            guard let selectAirlineVC = self?.showSelectAirlineVC() else { return }
            let tempNavVC = CustomUINavigationController(rootViewController: selectAirlineVC)
            selectAirlineVC.selectedAirlineClosure = { (airline) in
                addMyFlightVC.viewModel.saveAirline(airline: airline)
                addMyFlightVC.refreshUI()
                addMyFlightVC.dismiss(animated: true, completion: nil)
            }
            addMyFlightVC.present(tempNavVC, animated: true, completion: nil)
        }
        
        addMyFlightVC.saveShowFlightNumberClosure = { (flightNumber) in
            addMyFlightVC.viewModel.saveFlightNumber(flightNumber: flightNumber)
            addMyFlightVC.refreshUI()
        }

        return addMyFlightVC
    }
}
