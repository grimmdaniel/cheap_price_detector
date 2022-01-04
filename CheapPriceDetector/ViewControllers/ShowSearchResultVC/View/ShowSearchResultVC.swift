//
//  ShowSearchResultVC.swift
//  CheapPriceDetector
//
//  Created by grimmdaniel on 2021. 07. 12..
//

import UIKit
import SafariServices

class ShowSearchResultVC: UIViewController, StoryboardAble {
    
    var showFlightsTableViewDelegate: ShowFlightsTableViewDelegate!
    var showFlightsTableViewDataSource: ShowFlightsTableViewDataSource!
    @IBOutlet weak var showFlightsTableView: UITableView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
        setUpBackgroundImageView()
        setUpTableView()
        showFlightsTableViewDataSource.parentVC = self
    }
    
    fileprivate func setUpNavBar() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "sort-down"), style: .plain, target: self, action: #selector(sortButtonPressed))
        title = "showSearchResultVC_vc_title".localized
    }
    
    fileprivate func setUpTableView() {
        showFlightsTableView.delegate = showFlightsTableViewDelegate
        showFlightsTableView.dataSource = showFlightsTableViewDataSource
        showFlightsTableView.backgroundColor = .clear
        showFlightsTableView.separatorStyle = .none
        if #available(iOS 15.0, *) {
            showFlightsTableView.sectionHeaderTopPadding = 0
        }
    }
    
    fileprivate func setUpBackgroundImageView() {
        backgroundImageView.image = BackgroundSetter.defaultSetter.getBackgroundImage()
    }
    
    @objc func sortButtonPressed() {
        let actionSheetController = UIAlertController(title: "showSearchResultVC_sort_title".localized, message: "showSearchResultVC_sort_message".localized, preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "showSearchResultVC_sort_cancel".localized, style: .cancel) { (action) -> Void in
            actionSheetController.dismiss(animated: true, completion: nil)
        }
        actionSheetController.addAction(cancelAction)

        let sortByPriceAscending = UIAlertAction(title: "showSearchResultVC_sort_price_asc".localized, style: .default) { [weak self] (action) -> Void in
            self?.showFlightsTableViewDataSource.viewModel.sortFlights(by: .priceAscending)
            self?.showFlightsTableView.reloadData()
        }
        actionSheetController.addAction(sortByPriceAscending)
        
        let sortByPriceDescending = UIAlertAction(title: "showSearchResultVC_sort_price_desc".localized, style: .default) { [weak self] (action) -> Void in
            self?.showFlightsTableViewDataSource.viewModel.sortFlights(by: .priceDescending)
            self?.showFlightsTableView.reloadData()
        }
        actionSheetController.addAction(sortByPriceDescending)
        
        let sortByNightsAscending = UIAlertAction(title: "showSearchResultVC_sort_nights_asc".localized, style: .default) { [weak self] (action) -> Void in
            self?.showFlightsTableViewDataSource.viewModel.sortFlights(by: .nightsAscending)
            self?.showFlightsTableView.reloadData()
        }
        actionSheetController.addAction(sortByNightsAscending)
        
        let sortByNightsDescending = UIAlertAction(title: "showSearchResultVC_sort_nights_desc".localized, style: .default) { [weak self] (action) -> Void in
            self?.showFlightsTableViewDataSource.viewModel.sortFlights(by: .nightsDescending)
            self?.showFlightsTableView.reloadData()
        }
        actionSheetController.addAction(sortByNightsDescending)
        
        let sortByDateAscending = UIAlertAction(title: "showSearchResultVC_sort_dates_earliest".localized, style: .default) { [weak self] (action) -> Void in
            self?.showFlightsTableViewDataSource.viewModel.sortFlights(by: .earliestDate)
            self?.showFlightsTableView.reloadData()
        }
        actionSheetController.addAction(sortByDateAscending)
        
        let sortByDateDescending = UIAlertAction(title: "showSearchResultVC_sort_dates_latest".localized, style: .default) { [weak self] (action) -> Void in
            self?.showFlightsTableViewDataSource.viewModel.sortFlights(by: .latestDate)
            self?.showFlightsTableView.reloadData()
        }
        actionSheetController.addAction(sortByDateDescending)
        
        actionSheetController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        self.present(actionSheetController, animated: true, completion: nil)
    }
}

extension ShowSearchResultVC: AirlineBookingSiteOpenAble {
    
    func openAirlineBookingSite(_ url: URL) {
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true, completion: nil)
    }
}
