//
//  UserCityListPresenter+ItemViewModel.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 17/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation.NSUnit
import Foundation.NSDate

extension UserCityListItemViewModel {
    
    init(_ userCity: UserCity, lastWeather: LastWeather, temperatureUnit: UnitTemperature, dateFormatter: @escaping (Date) -> String) {
        self.identifier = "\(userCity.location)" // !!!
        self.icon = {
            switch userCity.location {
            case .cityId:
                return nil
            case .coordinate:
                return .bundled(#imageLiteral(resourceName: "icons8-map_marker"))
            case .currentLocation:
                return .bundled(#imageLiteral(resourceName: "icons8-near_me"))
            }
        }()
        
        self.temperatureUnit = temperatureUnit
        self.lastWeatherModel = lastWeather.map { (lastWeatherInfo) in
            let weather = lastWeatherInfo.weather
            let temperature = temperatureTextFromWeather(weather, temperatureUnit: temperatureUnit)
            let cityName = weather?.cityName ?? "..."
            let subtitle = weather.flatMap { dateFormatter($0.dateReceived) } ?? userCity.cityName
            return UserCityListItemWeatherViewModel(
                subtitle: subtitle,
                temperature: temperature,
                cityName: cityName,
                textColor: {
                    if lastWeatherInfo.requestIsInProgress {
                        return .gray
                    }
                    if lastWeatherInfo.errored {
                        return .red
                    }
                    if nil == lastWeatherInfo.updateDate {
                        return .blue
                    }
                    return .black
            }()
            )
        }
        self.userInfo = UserCityWithLastWeather(userCity, lastWeather)
    }
    
    var lastWeather: LastWeather {
        return self.userCityWithLastWeather.lastWeather
    }
    
    var userCity: UserCity {
        return self.userCityWithLastWeather.userCity
    }
    
    var userCityWithLastWeather: UserCityWithLastWeather {
        return self.userInfo as! UserCityWithLastWeather
    }
}

extension UserCity {
    
    init(from viewModel: UserCityListItemViewModel) {
        self = (viewModel.userInfo as! UserCityWithLastWeather).userCity
    }
}
