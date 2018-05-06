//
//  OpenWeatherMapLocationPredicate.swift
//  WeatherApp
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

/// OpenWeatherMap-specific location predicate.
enum OpenWeatherMapLocationPredicate : Codable, Equatable {
    
    case cityName(String)
    case cityId(Int)
    case coordinate(Coordinate)
    case zipCode(String, countryCode: String)

    struct Coordinate : Codable, Equatable {
        let lat: Double
        let lon: Double
    }
}

extension OpenWeatherMapLocationPredicate {
    init(_ weatherLocationPredicate: WeatherLocationPredicate) {
        switch weatherLocationPredicate {
        case .cityName(let cityName):
            self = .cityName(cityName)
        case .coordinate(let coordinate):
            self = .coordinate(.init(lat: coordinate.latitude, lon: coordinate.longitude))
        case .zipCode(let zipCode, countryCode: let countryCode):
            self = .zipCode(zipCode, countryCode: countryCode)
        }
    }
}

extension OpenWeatherMapLocationPredicate : Identifiable {
    
    typealias Identifier = Coordinate
}
