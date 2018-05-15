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
        
        if let coordinate = model.cityCoordinate {
            let centerCoordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            mapView.region = MKCoordinateRegionMakeWithDistance(centerCoordinate, 10000, 10000)
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
