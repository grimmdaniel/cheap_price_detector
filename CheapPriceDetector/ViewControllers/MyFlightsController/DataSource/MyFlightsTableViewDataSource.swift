//
//  MyFlightsTableViewDataSource.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 08. 24..
//

import UIKit

class MyFlightsTableViewDataSource: NSObject, UITableViewDataSource {

    private let dataStore: PersistableFlight
    weak var parentVC: UIViewController?

    init(with dataStore: PersistableFlight) {
        self.dataStore = dataStore
        super.init()
        dataStore.readItems(completed: { [weak self] (flights) in
            self?.myFlights = flights
            (self?.parentVC as? MyFlightsVC)?.myFlightsTableview.reloadData()
        })
    }

    var myFlights = [MyFlight]()

    func saveElement(flightRaw: [String:Any]) {
        if let myFlight = dataStore.persist(item: flightRaw) {
            guard let parentVC = parentVC as? MyFlightsVC else { return }
            myFlights.append(myFlight)
            parentVC.myFlightsTableview.beginUpdates()
            parentVC.myFlightsTableview.insertSections(IndexSet(integer: myFlights.count - 1), with: .automatic)
            parentVC.myFlightsTableview.endUpdates()
        }
    }

    private func deleteElement(index: Int) {
        let removedFlight = myFlights.remove(at: index)
        dataStore.delete(item: removedFlight)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return myFlights.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyFlightsCell.cellID) as? MyFlightsCell else { return UITableViewCell() }
        cell.currentMyFlight = myFlights[indexPath.section]
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            confirmItemDeletion(index: indexPath.section)
        }
    }

    func confirmItemDeletion(index: Int) {
        let alert = UIAlertController(title: "myFlightsVC_delete_flight_prompt_title".localized, message: "myFlightsVC_delete_flight_prompt_message".localized, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "myFlightsVC_delete_flight_delete".localized, style: .destructive) { [weak self] (action) in
            guard let parentVC = self?.parentVC as? MyFlightsVC else { return }
            self?.deleteElement(index: index)
            parentVC.myFlightsTableview.deleteSections(IndexSet(integer: index), with: .fade)
        }
        let cancelAction = UIAlertAction(title: "myFlightsVC_delete_flight_cancel".localized, style: .cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        parentVC?.present(alert, animated: true, completion: nil)
    }
}
