//
//  WeatherLocationPredicate.swift
//  WeatherAppTests
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

struct WeatherCoordinate {
    let latitude: Double
    let longitude: Double
}

enum WeatherLocationPredicate {
    case cityName(String)
    case coordinate(WeatherCoordinate)
    case zipCode(String, countryCode: String)
}
