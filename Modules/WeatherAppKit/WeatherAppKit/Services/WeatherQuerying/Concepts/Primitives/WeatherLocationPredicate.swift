//
//  WeatherLocationPredicate.swift
//  WeatherApp
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

enum CityPredicate {
    
    case cityId(String)
    case cityName(String)
    case coordinate(WeatherCoordinate)
    case zipCode(String, countryCode: String)
}

typealias WeatherLocationPredicate = CityPredicate
typealias WeatherCoordinate = CityCoordinate
