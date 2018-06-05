//
//  UserCityListItemView.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift
import UIKit

protocol UserCityListItemView : class {
    
    var model: UserCityListItemViewModel! { get set }
}

struct UserCityListItemWeatherViewModel {
    
    let subtitle: String
    let temperature: String
    let cityName: String
    let textColor: UIColor
}

struct UserCityListItemViewModel {
    
    let temperatureUnit: UnitTemperature
    let icon: UIImage?

    let lastWeatherModel: Observable<UserCityListItemWeatherViewModel>
    
    let identifier: String
    let userInfo: Any!
}
