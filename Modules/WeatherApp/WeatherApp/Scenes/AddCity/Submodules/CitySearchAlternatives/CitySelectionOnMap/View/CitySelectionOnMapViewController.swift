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

protocol CitySelectionOnMapView : class {
    
    var delegate: CitySelectionOnMapViewDelegate! { get set }
}

class CitySelectionOnMapViewController: UIViewController, CitySelectionOnMapView {

    @IBOutlet var mapView: MKMapView!
    
    @IBAction func cancel(_ sender: Any) {
        delegate.didCancel()
    }
    
    @IBAction func done(_ sender: Any) {
        let coordinate = mapView.centerCoordinate
        let cityCoordinate = CityCoordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)
        delegate.didSelect(cityCoordinate)
    }
    
    // MARK: - <CitySelectionOnMapView>
    
    weak var delegate: CitySelectionOnMapViewDelegate!
}
