//
//  ShowFlightsTableViewDataSource.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 07. 27..
//

import UIKit

class ShowFlightsTableViewDataSource: NSObject, UITableViewDataSource {
    
    let viewModel: ShowSearchResultViewModel
    weak var parentVC: AirlineBookingSiteOpenAble?
    
    init(viewModel: ShowSearchResultViewModel) {
        self.viewModel = viewModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultFlightCell.cellID, for: indexPath) as? ResultFlightCell else { return UITableViewCell() }
        cell.currentFlight = viewModel.getFlight(for: indexPath.section)
        cell.buySelectedFlightClosure = { [weak self] (flight) in
            guard let urlString = self?.viewModel.createFlightBookingURL(flight: flight), let url = URL(string: urlString) else { return }
            self?.parentVC?.openAirlineBookingSite(url)
        }
        return cell
    }
}
