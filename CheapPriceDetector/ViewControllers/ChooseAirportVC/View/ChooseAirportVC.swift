//
//  ChooseAirportVC.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 06. 23..
//

import UIKit

class ChooseAirportVC: UIViewController, StoryboardAble {
    
    var airportClosure: ((Airport) -> Void)?
    var selectAirportTableViewDataSource: SelectAirportTableViewDataSource!
    let searchController = AirportSearchBarView()

    @IBOutlet weak var selectAirportTableView: UITableView!
    
    fileprivate func setUpTableView() {
        selectAirportTableViewDataSource.parentVC = self
        selectAirportTableView.delegate = self
        selectAirportTableView.dataSource = selectAirportTableViewDataSource
        selectAirportTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        setUpnavBar()
        searchController.searchResultsUpdater = self
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchController.isSearchBarEmpty
    }
    
    fileprivate func setUpnavBar() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        title = "chooseAirportVC_vc_title".localized
    }
}

extension ChooseAirportVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        airportClosure?(selectAirportTableViewDataSource.viewModel.getAirport(for: indexPath.section, searching: isFiltering))
    }
}

extension ChooseAirportVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            selectAirportTableViewDataSource.filterContentForSearchText(searchText)
            selectAirportTableView.reloadData()
        }
    }
}
