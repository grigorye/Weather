//
//  UserCity.swift
//  WeatherApp
//
//  Created by Grigory Entin on 03/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation.NSDate

struct UserCity : Equatable {

    let location: UserCityLocation
    var weather: WeatherInfo?

    let cityName: String
    let dateAdded: Date
    
    var dateWeatherUpdated: Date?
    var dateWeatherRequested: Date?
    var errored: Bool
    var hasWeatherQueryInProgress: Bool
}

extension UserCity {
    
    init(with location: UserCityLocation, weather: WeatherInfo? = nil, cityName: String) {
        
        let now = Date()
        self.init(location: location, weather: weather, cityName: cityName, dateAdded: now, dateWeatherUpdated: nil, dateWeatherRequested: nil, errored: false, hasWeatherQueryInProgress: false)
    }
}

import Then

extension UserCity : Then {}
