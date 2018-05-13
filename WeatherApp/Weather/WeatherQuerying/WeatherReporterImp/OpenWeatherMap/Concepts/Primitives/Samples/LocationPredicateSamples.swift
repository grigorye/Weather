//
//  LocationPredicateSamples.swift
//  WeatherApp/OpenWeatherMap
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import WeatherApp

extension OpenWeatherMap$ {
    
    /// All variants of (existing) locations for testing.
    static var locationPredicateSamplesWithContext: [(String, LocationPredicate)] = [
        ("cityName", .cityName("London")),
        ("cityId", .cityId(2172797)),
        ("coordinate", .coordinate(.init(lat: 0, lon: 0))),
        ("zipCode", .zipCode("1333", countryCode: "nl"))
    ]
    
    /// All variants of (missing) locations for testing.
    static var missingLocationPredicateSamplesWithContext: [(String, LocationPredicate)] = [
        ("cityName", .cityName("Lond")),
        ("zipCode", .zipCode("1333ML", countryCode: "nl"))
    ]
}

extension OpenWeatherMap$$ /* *** AUTOGENERATED *** */ {
    var locationPredicateSamplesWithContext: [(String, LocationPredicate)] {
        return OpenWeatherMap$.locationPredicateSamplesWithContext
    }
    var missingLocationPredicateSamplesWithContext: [(String, LocationPredicate)] {
        return OpenWeatherMap$.missingLocationPredicateSamplesWithContext
    }
}
