//
//  WeatherDetailMapViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 14/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import MapKit
import UIKit

class WeatherDetailMapViewController : UIViewController, WeatherDetailView {
    
    // MARK: - <WeatherDetailView>
    
    var model: WeatherDetailViewModel! {
        didSet {
            configureView()
        }
    }
    
    // MARK: -
    
    private func configureView() {
        
        if let cityCoordinate = model.cityCoordinate {
            let coordinate = CLLocationCoordinate2D(latitude: cityCoordinate.latitude, longitude: cityCoordinate.longitude)
            mapView.region = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000)
            let pointAnnotation = MKPointAnnotation().then { $0.coordinate = coordinate }
            mapView.addAnnotation(pointAnnotation)
        }
    }
    
    // MARK: -
    
    var mapView: MKMapView {
        _ = view
        return _mapView
    }
    
    @IBOutlet private var _mapView: MKMapView!
    
    // MARK: -
    
    deinit {()}
}
