//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol WeatherDetailView : class {
    
    var model: WeatherDetailViewModel! { get set }
}

struct WeatherDetailViewModel {
    
    let title: String
    let temperature: String
    let cityCoordinate: CityCoordinate?
}
