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

struct LastWeatherInfo : Equatable {
    
    let requestIsInProgress: Bool
    let requestDate: Date?
    let updateDate: Date?
    let errored: Bool
    let weather: WeatherInfo?
}
