//
//  LocationPredicate+WeatherLocationPredicate.swift
//  WeatherApp/OpenWeatherMap
//
//  Created by Grigory Entin on 06/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import OpenWeatherMapKit

extension OpenWeatherMapKit.LocationPredicate {
    
    init(_ canonicPredicate: WeatherLocationPredicate) {
        switch canonicPredicate {
        case .cityId(let cityId):
            if cityId.isEmpty {
                self = .cityId(0)
            } else {
                self = .cityId(Int(cityId)!)
            }
        case .cityName(let cityName):
            self = .cityName(cityName)
        case .coordinate(let coordinate):
            self = .coordinate(.init(lat: coordinate.latitude, lon: coordinate.longitude))
        case .zipCode(let zipCode, countryCode: let countryCode):
            self = .zipCode(zipCode, countryCode: countryCode)
        }
    }
}
