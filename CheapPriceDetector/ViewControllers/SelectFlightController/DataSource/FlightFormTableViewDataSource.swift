//
//  FlightFormTableViewDataSource.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 07. 27..
//

import UIKit

class FlightFormTableViewDataSource: NSObject, UITableViewDataSource {
    
    let viewModel: SelectFlightViewModel
    
    init(viewModel: SelectFlightViewModel) {
        self.viewModel = viewModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID: String
        if indexPath.section == 0 {
            cellID = SelectAirportCell.cellID
           guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? SelectAirportCell else { return UITableViewCell() }
            cell.currentJourney = viewModel.currentJourney
            return cell
        } else if indexPath.section == 1 {
            cellID = NightSelectCell.cellID
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? NightSelectCell else { return UITableViewCell() }
            cell.currentNights = viewModel.getNumberOfNights()
            return cell
        } else if indexPath.section == 2 {
            cellID = SelectDateCell.cellID
           guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? SelectDateCell else { return UITableViewCell() }
            cell.currentJourney = viewModel.currentJourney
            return cell
        } else if indexPath.section == 3 {
            cellID = DiscountClubCell.cellID
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? DiscountClubCell else { return UITableViewCell() }
             return cell
        } else if indexPath.section == 4 {
            cellID = SearchFlightButtonCell.cellID
           guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? SearchFlightButtonCell else { return UITableViewCell() }
            return cell
        } else {
            cellID = ResetSearchCell.cellID
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? ResetSearchCell else { return UITableViewCell() }
            return cell
        }
    }
}
