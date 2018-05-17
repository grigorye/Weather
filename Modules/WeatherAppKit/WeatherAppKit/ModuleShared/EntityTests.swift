//
//  EntityTests.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 17/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import WeatherAppKit

let currentLocationUserCitySample = UserCity(with: .currentLocation, cityName: "Current Location")

let userCitySample = currentLocationUserCitySample

let minimumLastWeatherInfoSample = LastWeatherInfo(requestIsInProgress: false, requestDate: nil, updateDate: nil, errored: false, weather: nil)

let lastWeatherInfoSample = minimumLastWeatherInfoSample
