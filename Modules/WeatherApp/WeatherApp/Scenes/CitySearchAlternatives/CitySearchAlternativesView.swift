//
//  CitySearchAlternativesView.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol CitySearchAlternativesViewDelegate : class {
    
    func selectedCurrentLocation()
    func selectedSelectOnMap()
}

protocol CitySearchAlternativesView : View {
    
    var delegate: CitySearchAlternativesViewDelegate! { get set }
}
