//
//  SelectAirportTableViewDataSource.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 07. 27..
//

import UIKit

class SelectAirportTableViewDataSource: NSObject, UITableViewDataSource {
    
    let viewModel: SelectAirportViewModel!
    weak var parentVC: ChooseAirportVC?
    
    init(viewModel: SelectAirportViewModel) {
        self.viewModel = viewModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let numberOfSections = viewModel.numberOfSections(searching: parentVC?.isFiltering ?? true)
        if numberOfSections == 0 {
            tableView.showEmptyTableViewMessage(message: "chooseAirportVC_vc_search_empty_result".localized)
        } else {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
        }
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AirportCell.cellID) as? AirportCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.currentAirport = viewModel.getAirport(for: indexPath.section, searching: parentVC?.isFiltering ?? true)
        return cell
    }
    
    func filterContentForSearchText(_ searchText: String) {
        viewModel.searchAirports(searchText)
    }
}
