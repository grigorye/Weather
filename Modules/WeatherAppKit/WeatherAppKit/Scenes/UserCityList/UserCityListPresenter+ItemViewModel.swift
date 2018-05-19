//
//  UserCityListPresenter+ItemViewModel.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 17/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit.UIImage
import Foundation.NSUnit
import Foundation.NSDate

extension UserCityListItemViewModel {
    
    init(_ userCityInfo: UserCityInfo, lastWeather: LastWeather, temperatureUnit: UnitTemperature, dateFormatter: @escaping (Date) -> String) {
        self.identifier = "\(userCityInfo.location)" // !!!
        
        let rawIcon: UIImage? = {
            switch userCityInfo.location {
            case .cityId:
                return nil
            case .coordinate:
                return .bundled(#imageLiteral(resourceName: "icons8-map_marker"))
            case .currentLocation:
                return .bundled(#imageLiteral(resourceName: "icons8-near_me"))
            }
        }()
        let icon = rawIcon?.withRenderingMode(.alwaysOriginal)
        self.icon = icon
        
        self.temperatureUnit = temperatureUnit
        self.lastWeatherModel = lastWeather.map { (lastWeatherInfo) in
            let weather = lastWeatherInfo.weather
            let temperature = temperatureTextFromWeather(weather, temperatureUnit: temperatureUnit)
            let cityName = weather?.cityName ?? "..."
            let subtitle = weather.flatMap { dateFormatter($0.dateReceived) } ?? userCityInfo.cityName
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
        self.userInfo = UserCityInfoAndLastWeather(userCityInfo, lastWeather)
    }
    
    var lastWeather: LastWeather {
        return self.userCityInfoAndLastWeather.lastWeather
    }
    
    var userCityInfo: UserCityInfo {
        return self.userCityInfoAndLastWeather.userCityInfo
    }
    
    var userCityInfoAndLastWeather: UserCityInfoAndLastWeather {
        return self.userInfo as! UserCityInfoAndLastWeather
    }
}
