//
//  ChooseAirportsOnMapVC.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 08. 03..
//

import UIKit
import MapKit
import CoreLocation

class ChooseAirportsOnMapVC: BaseMapVC, StoryboardAble {
    
    var viewModel: ChooseAirportsOnMapViewModel!
    var selectedAirportsClosure: ((Airport,Airport) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpnavBar()
        zoomToInitialMapView()
        airportsMapView.delegate = self
        airportsMapView.addAnnotations(viewModel.airportPins)
    }

    fileprivate func setUpnavBar() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(airportSelectionDone)),
            UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetMap))
        ]
        title = "chooseAirportsOnMapVC_vc_title".localized
    }
    
    @objc func airportSelectionDone() {
        guard let originAirport = viewModel.currentOriginAirportSelected else { return }
        guard let destinationAirport = viewModel.currentDestinationAirportSelected else { return }
        selectedAirportsClosure?(originAirport,destinationAirport)
    }
    
    @objc func resetMap() {
        showInitialMapState()
    }
}

extension ChooseAirportsOnMapVC {
    
    func refreshAnnotations() {
        airportsMapView.removeAnnotations(airportsMapView.annotations)
        airportsMapView.addAnnotations(viewModel.airportPins)
    }
    
    func showInitialMapState() {
        title = "chooseAirportsOnMapVC_vc_title".localized
        viewModel.currentOriginAirportSelected = nil
        viewModel.currentDestinationAirportSelected = nil
        viewModel.deselectAllAnnotations()
        airportsMapView.removeOverlays(airportsMapView.overlays)
        refreshAnnotations()
        zoomToInitialMapView()
    }
    
    func zoomToSelectedAnnotations() {
        let annotationsToZoomOn = airportsMapView.annotations.filter { (annot) -> Bool in
            guard let airportAnnot = annot as? AirportAnnotation else { return false }
            guard let originAirportAnnot = viewModel.currentOriginAirportSelected else { return false }
            guard let destinationAirportAnnot = viewModel.currentDestinationAirportSelected else { return false }
            return airportAnnot.airport.iataCode == destinationAirportAnnot.iataCode || airportAnnot.airport.iataCode == originAirportAnnot.iataCode
        }
        airportsMapView.showAnnotations(annotationsToZoomOn, animated: true)
    }
    
    func removeNonReachableAirports(from origin: Airport) {
        let destinationCodes = viewModel.getAllDestinationAirportCodes(to: origin)
        let annotationsToRemove = airportsMapView.annotations.filter { (annots) -> Bool in
            guard let airportAnnot = annots as? AirportAnnotation else { return true }
            return !destinationCodes.contains(airportAnnot.airport.iataCode)
        }
        airportsMapView.removeAnnotations(annotationsToRemove)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? AirportAnnotation else { return }
        guard let markerAnnotation = view as? MKMarkerAnnotationView else { return }
        airportsMapView.deselectAnnotation(annotation, animated: false)
        let selectedAirport = annotation.airport
        if let currentAirport = viewModel.currentOriginAirportSelected {
            if currentAirport == selectedAirport { // same airport was selected again
                showInitialMapState()
            } else { // we have a route
                guard (viewModel.currentDestinationAirportSelected == nil) else { return }
                viewModel.currentDestinationAirportSelected = selectedAirport
                annotation.isSelected = true
                markerAnnotation.markerTintColor = ColorTheme.primaryColor
                zoomToSelectedAnnotations()
                title = viewModel.getRouteDistanceText()
                guard let originCoord = currentAirport.coordinate, let destinationCoord = selectedAirport.coordinate else { return }
                drawCurvyLineBetweenPoints(originCoord, destinationCoord)
            }
        } else { // select origin airport
            viewModel.currentOriginAirportSelected = selectedAirport
            removeNonReachableAirports(from: selectedAirport)
            annotation.isSelected = true
            markerAnnotation.markerTintColor = ColorTheme.primaryColor
        }
    }
}
