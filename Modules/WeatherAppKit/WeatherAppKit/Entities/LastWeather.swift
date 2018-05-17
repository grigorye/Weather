//
//  LastWeather.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 17/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift
import Foundation.NSDate

typealias LastWeather = Observable<LastWeatherInfo>

struct LastWeatherInfo {
    
    let requestIsInProgress: Bool
    let requestDate: Date?
    let updateDate: Date?
    let errored: Bool
    let weather: WeatherInfo?
}

extension UserCity {
    
    var lastWeatherInfo: LastWeatherInfo {
        return .init(
            requestIsInProgress: self.hasWeatherQueryInProgress,
            requestDate: self.dateWeatherRequested,
            updateDate: self.dateWeatherUpdated,
            errored: self.errored,
            weather: self.weather
        )
    }
}
