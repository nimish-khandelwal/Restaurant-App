//
//  ViewController.swift
//  Food Order
//
//  Created by Ramesh Pendyala on 25/03/25.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.setupMapView()
    }
    
    func setupMapView() {
            mapView?.delegate = self
            let outlets = generateRandomFoodOutlets(count: 10)
            
            for outlet in outlets {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(outlet.lat), longitude: CLLocationDegrees(outlet.long))
                annotation.title = outlet.name
                annotation.subtitle = "Rating: \(outlet.rating) - \(outlet.address)"
                mapView?.addAnnotation(annotation)
            }
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard !(annotation is MKUserLocation) else { return nil }
            
            let identifier = "OutletPin"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
            
            if let title = annotation.title, let outlet = generateRandomFoodOutlets(count: 1).first(where: { $0.lat == annotation.coordinate.latitude && $0.long == annotation.coordinate.longitude }) {
                if outlet.isFavourite {
                    annotationView?.glyphImage = UIImage(systemName: "star.fill")
                    annotationView?.markerTintColor = .systemPink
                } else {
                    annotationView?.glyphImage = UIImage(systemName: "fork.knife")
                    annotationView?.markerTintColor = .blue
                }
            }
            return annotationView
        }
    }


