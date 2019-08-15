//
//  CityMapViewController.swift
//  CityList
//
//  Created by riza milani on 5/17/1398 AP.
//  Copyright © 1398 riza milani. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CityMapViewController: UIViewController {

    let locationManager = CLLocationManager()
    var mapView: MKMapView!
    var coordinator: Coord? {
        didSet {
            setupMapKit()
            if let lat = coordinator?.lat,
                let lon = coordinator?.lon {
                let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                self.mapView.setRegion(region, animated: true)
            }
        }
    }

    func setupMapKit() {
        if mapView != nil {
            return
        }
        viewDidLoad()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = MKMapView()
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        view.addSubview(mapView)
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
