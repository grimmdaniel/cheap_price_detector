//
//  ShowMyFlightsOnMapVC.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 12. 26..
//

import UIKit
import MapKit

class ShowMyFlightsOnMapVC: BaseMapVC, StoryboardAble {
    
    var viewModel: ShowMyFlightsOnMapViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpnavBar()
        zoomToInitialMapView()
        airportsMapView.delegate = self
        airportsMapView.addAnnotations(viewModel.airportAnnotations)
        drawLinesBetweenAirports()
    }
    
    fileprivate func setUpnavBar() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        title = "showMyFlightsOnMapVC_title".localized
    }
    
    func drawLinesBetweenAirports() {
        let lineData = viewModel.getLineData()
        lineData.forEach { data in
            drawCurvyLineBetweenPoints(data.0,data.1,lineColor: data.2)
        }
    }
}
