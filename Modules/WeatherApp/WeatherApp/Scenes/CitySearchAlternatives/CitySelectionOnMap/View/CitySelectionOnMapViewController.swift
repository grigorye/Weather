//
//  CitySelectionOnMapViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import MapKit
import UIKit

protocol CitySelectionOnMapViewDelegate : class {
    
    func didSelect(_ coordinate: CityCoordinate)
    func didCancel()
}

class CitySelectionOnMapViewController: UIViewController {

    // MARK: -
    
    weak var delegate: CitySelectionOnMapViewDelegate!

    // MARK: -
    
    @IBOutlet private var mapView: MKMapView!
    
    @IBAction private func cancel(_ sender: Any) {
        delegate.didCancel()
    }
    
    @IBAction private func done(_ sender: Any) {
        let coordinate = mapView.centerCoordinate
        let cityCoordinate = CityCoordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)
        delegate.didSelect(cityCoordinate)
    }
}
