//
//  SettingsViewController.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 17..
//

import UIKit

class MyFlightsVC: UIViewController, StoryboardAble {

    var tableViewDataSource: MyFlightsTableViewDataSource!
    var tableViewDelegate: MyFlightTableViewDelegate!
    var addNewFlightClosure: (() -> Void)?
    var showFlightsOnMapClosure: (([MyFlight]) -> Void)?

    @IBOutlet weak var myFlightsTableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpnavBar()
        setUpTableView()
        tableViewDataSource.parentVC = self
    }
    
    fileprivate func setUpnavBar() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewFlight)),
            UIBarButtonItem(image: UIImage(named: "map_navbar"), style: .plain, target: self, action: #selector(showMyFlightsOnMap))
        ]
        title = "myFlightsVC_vc_title".localized
    }

    fileprivate func setUpTableView() {
        myFlightsTableview.delegate = tableViewDelegate
        myFlightsTableview.dataSource = tableViewDataSource
        myFlightsTableview.backgroundColor = .clear
        myFlightsTableview.separatorStyle = .none
        if #available(iOS 15.0, *) {
            myFlightsTableview.sectionHeaderTopPadding = 0
        }
    }
    
    @objc func addNewFlight() {
        addNewFlightClosure?()
    }

    @objc func showMyFlightsOnMap() {
        showFlightsOnMapClosure?(tableViewDataSource.myFlights)
    }

    private func fetchMyFlights() {
//        print(persistentDataStore.readItems())
    }
}
