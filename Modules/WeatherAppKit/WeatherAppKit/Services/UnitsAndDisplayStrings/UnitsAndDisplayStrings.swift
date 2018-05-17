//
//  UnitsAndDisplayStrings.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 17/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation.NSUnit

var defaultTemperatureUnit: UnitTemperature {
    return .celsius
}

func temperatureTextFromWeather(_ weather: WeatherInfo?, temperatureUnit: UnitTemperature) -> String {
    
    guard let weather = weather else {
        return "."
    }
    
    let temperatureValue = weather.temperature.converted(to: temperatureUnit).value
    let temperatureString = NumberFormatter.localizedString(from: .init(value: temperatureValue), number: .none)
    return String(format: NSLocalizedString("%@%@", comment: ""), temperatureString, temperatureUnit.symbol)
}

// MARK: -

func defaultTimeFormatter(_ date: Date) -> String {
    
    return DateFormatter.localizedString(from: date, dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.short)
}
