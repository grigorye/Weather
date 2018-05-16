//
//  CitySelectionOnMapView.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol CitySelectionOnMapView : View {
    
    var delegate: CitySelectionOnMapViewDelegate! { get set }
}

protocol CitySelectionOnMapViewDelegate : class {
    
    func didSelect(_ coordinate: CityCoordinate)
    func didCancel()
}
