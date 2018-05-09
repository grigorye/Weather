//
//  WeatherDataService.swift
//  WeatherApp
//
//  Created by Grigory Entin on 03/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation

protocol WeatherDataServiceOutput {
    associatedtype Location

    func didAddWeatherInfo(for location: Location)
    func didClearWeatherInfo(for location: Location)
    func didRetrieveWeatherInfos()
}

protocol WeatherDataService {
    associatedtype Location

    func set(weatherInfo: WeatherInfo, for location: Location)
    func clearWeatherInfo(for location: Location)
    func retrieveWeatherInfos()
}
