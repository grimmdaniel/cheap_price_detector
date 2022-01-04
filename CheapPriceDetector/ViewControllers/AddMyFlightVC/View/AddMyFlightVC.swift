//
//  AddMyFlightVC.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 08. 30..
//

import UIKit

class AddMyFlightVC: UIViewController, StoryboardAble {

    @IBOutlet weak var backgroundRoundedView: UIView!
    @IBOutlet weak var saveFlightButton: UIButton!

    @IBOutlet weak var originAirportNameLabel: UILabel!
    @IBOutlet weak var originAirportValueLabel: UILabel!
    @IBOutlet weak var destinationAirportNameLabel: UILabel!
    @IBOutlet weak var destinationAirportValueLabel: UILabel!
    @IBOutlet weak var dateNameLabel: UILabel!
    @IBOutlet weak var dateValueLabel: UILabel!
    @IBOutlet weak var airlineNameLabel: UILabel!
    @IBOutlet weak var airlineValueLabel: UILabel!
    @IBOutlet weak var flightNumberValueLabel: UILabel!
    @IBOutlet weak var flightNumberNameLabel: UILabel!
    
    
    var selectDateClosure: (() -> Void)?
    var selectAirportOnMapClosure: (([Route]) -> Void)?
    var selectAirlineClosure: (() -> Void)?
    var saveShowFlightNumberClosure: ((String) -> Void)?

    var saveNewFlightClosure: (([String:Any]) -> Void)?
    var viewModel: AddMyFlightViewModel!
    private let placeholderText = "N/A"

    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundRoundedView.layer.cornerRadius = 5.0
        saveFlightButton.setTitleColor(ColorTheme.primaryColor, for: .normal)
        setUpTranslations()
    }

    @IBAction func closeVCButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func saveFlightButtonPressed(_ sender: UIButton) {
        if viewModel.isItFullyCompleted() {
            saveNewFlightClosure?(viewModel.generateMyFlightRawData())
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func selectDateButtonPressed(_ sender: UIButton) {
        selectDateClosure?()
    }

    @IBAction func selectAiportsOnMapPressed(_ sender: UIButton) {
        selectAirportOnMapClosure?(viewModel.routes)
    }
    
    @IBAction func selectAirlineButtonPressed(_ sender: UIButton) {
        selectAirlineClosure?()
    }
    
    
    @IBAction func selectFlightNumberPressed(_ sender: UIButton) {
        showFlightNumberTextfield()
    }
    
    @IBAction func changeAirports(_ sender: UIButton) {
        viewModel.changeAirports()
        refreshUI()
    }
    
    private func setUpTranslations() {
        originAirportNameLabel.text = "addMyFlightVC_origin_airportLabel".localized
        destinationAirportNameLabel.text = "addMyFlightVC_destination_airportLabel".localized
        originAirportValueLabel.text = "addMyFlightVC_origin_airport_placeholder".localized
        destinationAirportValueLabel.text = "addMyFlightVC_destination_airport_placeholder".localized
        dateNameLabel.text = "addMyFlightVC_journey_date_label".localized
        dateValueLabel.text = "N/A"
        airlineNameLabel.text = "addMyFlightVC_airline_label".localized
        flightNumberNameLabel.text = "addMyFlightVC_flight_number_label".localized
        saveFlightButton.setTitle("addMyFlightVC_save_flight_label".localized, for: .normal)
    }
    
    private func showFlightNumberTextfield() {
        let alertContoller = UIAlertController.init(title: "addMyFlightVC_fnumber_title".localized, message: "addMyFlightVC_fnumber_message".localized, preferredStyle: .alert)
        alertContoller.addTextField { (textField) in
      
        }
        let action = UIAlertAction.init(title: "addMyFlightVC_fnumber_save".localized, style: .default) { [weak self] (action) in
            if let flightNumberText = alertContoller.textFields?.first?.text, flightNumberText != "" {
                self?.saveShowFlightNumberClosure?(flightNumberText)
            } else {
                self?.saveShowFlightNumberClosure?("0000")
            }
        }
        alertContoller.addAction(action)
        present(alertContoller, animated: true, completion:nil)
    }
    
    func refreshUI() {
        setUpTranslations()
        if let originAirport = viewModel.originAirport {
            originAirportValueLabel.text = "\(originAirport.airportName) (\(originAirport.iataCode))"
        } else {
            originAirportValueLabel.text = "addMyFlightVC_origin_airport_placeholder".localized
        }
        if let destinationAirport = viewModel.destinationAirport {
            destinationAirportValueLabel.text = "\(destinationAirport.airportName) (\(destinationAirport.iataCode))"
        } else {
            destinationAirportValueLabel.text = "addMyFlightVC_destination_airport_placeholder".localized
        }
        if let date = viewModel.flightDate {
            dateValueLabel.text = date.wizzDateFormat()
        } else {
            dateValueLabel.text = "N/A"
        }
        if let airline = viewModel.airline {
            airlineValueLabel.text = airline.name
        } else {
            airlineValueLabel.text = "N/A AIRWAYS"
        }
        if let flightNumber = viewModel.flightNumber {
            flightNumberValueLabel.text = flightNumber
        } else {
            flightNumberValueLabel.text = "0000"
        }
    }
}
