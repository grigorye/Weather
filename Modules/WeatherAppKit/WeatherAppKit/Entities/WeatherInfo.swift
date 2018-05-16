//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Grigory Entin on 03/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation.NSUnit

/// Minimum bit of information about a weather.
struct WeatherInfo : Codable, Equatable {
    
    let dateReceived: Date
    let temperature: Measurement<UnitTemperature>
    let cityName: String
    let cityCoordinate: CityCoordinate
}
