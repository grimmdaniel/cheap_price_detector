//
//  SelectFlightController.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 17..
//

import UIKit
import MultiSlider

class SelectFlightController: UIViewController, StoryboardAble {
    
    var service: SelectFlightService!
    var showMyFlightsScreenClosure: (([Route]) -> Void)?
    var selectAirportClosure: (([Airport],Bool) -> Void)?
    var selectAirportOnMapClosure: (([Route]) -> Void)?
    var selectDateClosure: ((DateRequester) -> Void)?
    var showSearchResultClosure: (([Flight]) -> Void)?
    var tableViewdelegate: FlightFormTableViewDelegate!
    var tableViewDataSource: FlightFormTableViewDataSource!
    
    
    @IBOutlet weak var flightFormTableView: UITableView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        service.flightDelegate = self
        service.routeDelegate = self
        service.fetchRoutes()
        
        setUpNavbar()
        setUpBackgroundImageView()
        setUpTableView()
        addLoadingOverlay()
    }
    
    fileprivate func setUpNavbar() {
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "user"), style: .plain, target: self, action: #selector(openMyFlightsViewVC))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40)))
    }
    
    @objc func openMyFlightsViewVC() {
        showMyFlightsScreenClosure?(tableViewDataSource.viewModel.getAllRoutes())
    }
    
    @IBAction func searchFlightButtonPressed(_ sender: UIButton) {
        guard let data = tableViewDataSource.viewModel.generateSearchData() else { return }
        service.fetchFlight(params: data)
    }
    
    @IBAction func selectDateButtonPressed(_ sender: UIButton) {
        if sender.tag == 10 {
            selectDateClosure?(.earliestDate)
        } else {
            selectDateClosure?(.latestDate)
        }
    }
    
    @IBAction func selectAiportsOnMapPressed(_ sender: UIButton) {
        selectAirportOnMapClosure?(tableViewDataSource.viewModel.getAllRoutes())
    }
    
    
    @IBAction func selectOriginAirportButtonPressed(_ sender: UIButton) {
        selectAirportClosure?(tableViewDataSource.viewModel.getAllOriginAirports(),true)
    }
    
    @IBAction func selectDestinationAirportButtonPressed(_ sender: UIButton) {
        if let currentOrigin = tableViewDataSource.viewModel.getCurrentOrigin() {
            selectAirportClosure?(tableViewDataSource.viewModel.getAllDestinationAirports(to: currentOrigin),false)
        }
    }
    
    
    @IBAction func resetSearchButtonPressed(_ sender: UIButton) {
        tableViewDataSource.viewModel.resetJourney()
        refreshData()
    }
    
    
    @IBAction func changeDirectionPressed(_ sender: UIButton) {
        tableViewDataSource.viewModel.changeOriginWithDestination()
        refreshData()
    }
    
    @IBAction func sliderChanged(slider: MultiSlider) {
        let min = Int(slider.value[0])
        let max = Int(slider.value[1])
        tableViewDataSource.viewModel.updateNumberOfNights(minN: min, maxN: max)
    }
    
    fileprivate func setUpTableView() {
        flightFormTableView.delegate = tableViewdelegate
        flightFormTableView.dataSource = tableViewDataSource
        flightFormTableView.backgroundColor = .clear
        flightFormTableView.separatorStyle = .none
        if #available(iOS 15.0, *) {
            flightFormTableView.sectionHeaderTopPadding = 0
        }
    }
    
    fileprivate func setUpBackgroundImageView() {
        backgroundImageView.image = BackgroundSetter.defaultSetter.getBackgroundImage()
    }
    
    func refreshData() {
        flightFormTableView.reloadData()
    }
}

extension SelectFlightController: SelectFlightDelegate & SelectRouteDelegate {
    
    func didFinishFetchinAllFlights(flights: [Flight]) {
        print("Finished downloading")
        removeLoadingOverlay()
        if flights.isEmpty {
            showErrorPopUp(title: "selectFlightVC_empty_result_title".localized, message: "selectFlightVC_empty_result_message".localized)
        } else {
            showSearchResultClosure?(flights)
        }
    }
    
    func didStartFetchingData() {
        print("Started downloading")
        addLoadingOverlay()
    }
    
    func didFinishFetchingRoutes(routes: [Route]) {
        tableViewDataSource.viewModel.refreshDataSource(routes: routes)
        print("Finished downloading")
        removeLoadingOverlay()
    }
    
    func didFailFetchingData(error: NetworkError) {
        print(error)
        removeLoadingOverlay()
    }
}
