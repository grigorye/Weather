//
//  UserCityWithLastWeather.swift
//  WeatherApp
//
//  Created by Grigory Entin on 11/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

typealias UserCityWithLastWeather = (userCity: UserCity, lastWeather: LastWeather)

extension UserCity {
    
    var hasWeatherQueryInProgress : Bool {
        
        guard let dateWeatherRequested = self.dateWeatherRequested else {
            return false
        }
        guard let dateWeatherUpdated = self.dateWeatherUpdated else {
            return true
        }
        return dateWeatherRequested > dateWeatherUpdated 
    }
}
