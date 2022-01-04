//
//  SelectAirlineDataSource.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 09. 24..
//

import UIKit

class SelectAirlineDataSource: NSObject, UITableViewDataSource {
    
    let viewModel: SelectAirlineViewModel!
    
    init(viewModel: SelectAirlineViewModel) {
        self.viewModel = viewModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectAirlineCell.cellID) as? SelectAirlineCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.currentAirline = viewModel.getAirline(for: indexPath.section)
        return cell
    }
}
