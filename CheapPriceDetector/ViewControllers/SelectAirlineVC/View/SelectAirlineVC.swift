//
//  SelectAirlineVC.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 09. 24..
//

import UIKit

class SelectAirlineVC: UIViewController, StoryboardAble {
    
    @IBOutlet weak var selectAirlineTableView: UITableView!
    var selectAirlineDataSource: SelectAirlineDataSource!
    var selectAirlineDelegate: SelectAirlineDelegate!
    var selectedAirlineClosure: ((Airline) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpnavBar()
        selectAirlineTableView.dataSource = selectAirlineDataSource
        selectAirlineTableView.delegate = selectAirlineDelegate
        selectAirlineDelegate.parentVC = self
    }

    fileprivate func setUpnavBar() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        title = "selectAirlineVC_title".localized
    }
    
    func selectAirline(index: Int) {
        let airline = selectAirlineDataSource.viewModel.getAirline(for: index)
        selectedAirlineClosure?(airline)
    }
}
