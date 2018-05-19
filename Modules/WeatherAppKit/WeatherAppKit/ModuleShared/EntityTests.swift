//
//  EntityTests.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 17/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import WeatherAppKit

let currentLocationUserCityInfoSample = UserCityInfo(location: .currentLocation, cityName: "Current Location")

let userCityInfoSample = currentLocationUserCityInfoSample
let cityCoordinateSample = CityCoordinate(latitude: -16.92, longitude: 145.77)

let weatherInfoSample = WeatherInfo(
    dateReceived: Date(timeIntervalSinceReferenceDate: 0),
    temperature: Measurement<UnitTemperature>(value: 24, unit: .celsius),
    cityName: "Current Location",
    cityCoordinate: cityCoordinateSample
)

let minimumLastWeatherInfoSample = LastWeatherInfo(requestIsInProgress: false, requestDate: nil, updateDate: nil, errored: false, weather: nil)

let lastWeatherInfoSample = minimumLastWeatherInfoSample
