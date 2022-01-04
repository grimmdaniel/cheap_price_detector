//
//  BaseMapVC.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 12. 26..
//

import UIKit
import MapKit

class BaseMapVC: UIViewController {
    
    @IBOutlet weak var airportsMapView: MKMapView!
    let mapCentre = CLLocationCoordinate2D(latitude:  48.23610, longitude: 21.22574)

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func zoomToInitialMapView() {
        airportsMapView.cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 1500000, maxCenterCoordinateDistance: 15000000)
        let span = MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40)
        let region = MKCoordinateRegion(center: mapCentre, span: span)
        airportsMapView.setRegion(region, animated: true)
    }
    
    func drawCurvyLineBetweenPoints(_ origin: CLLocationCoordinate2D,_ destination: CLLocationCoordinate2D, lineColor: UIColor = ColorTheme.primaryColor) {
        let arc = ArcOverlay(origin: origin, destination: destination,
                             style: LineOverlayStyle(strokeColor: lineColor,lineWidth: 4, alpha: 1))
        arc.radiusMultiplier = 0.5
        airportsMapView.addOverlay(arc)
    }
}

extension BaseMapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? AirportAnnotation  else { return nil }
        let identifier = "identifier"
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView.glyphImage = annotation.image
        annotationView.markerTintColor = annotation.isSelected ? ColorTheme.primaryColor : ColorTheme.secondaryColor
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let lineOverlay = overlay as? LineOverlay {
            return MapLineOverlayRenderer(lineOverlay)
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

