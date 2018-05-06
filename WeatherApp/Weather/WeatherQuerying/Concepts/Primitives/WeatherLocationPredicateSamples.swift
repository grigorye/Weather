//
//  WeatherLocationPredicateSamples.swift
//  WeatherAppTests
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import WeatherApp

/// All variants of locations for testing.
let weatherLocationPredicateSamplesWithContext: [(String, WeatherLocationPredicate)] = [
    
    ("cityName", .cityName("London")),
    ("coordinate", .coordinate(.init(latitude: 0, longitude: 0))),
    ("zipCode", .zipCode("1333ML", countryCode: "nl"))
]
