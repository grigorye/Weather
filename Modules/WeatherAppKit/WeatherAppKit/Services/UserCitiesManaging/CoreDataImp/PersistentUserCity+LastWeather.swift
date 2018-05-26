//
//  PersistentUserCity+LastWeather.swift
//  WeatherApp
//
//  Created by Grigory Entin on 15/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

extension PersistentUserCity {
    
    static let namesOfPropertiesAffectingLastWeather: Set<String> = [
        #keyPath(dateWeatherRequested),
        #keyPath(dateWeatherUpdated),
        #keyPath(errored),
        #keyPath(weatherJson),
        #keyPath(hasWeatherQueryInProgress)
    ]
}
