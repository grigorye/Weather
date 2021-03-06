//
//  WeatherProviderImpContainer.swift
//  WeatherApp/WeatherProviderImp
//
//  Created by Grigory Entin on 05/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import OpenWeatherMapKit
import Swinject

extension WeatherProviderImp_OpenWeatherMap$ {
    
    static var container = Container().then {
        $0.register(WeatherProvider.self) { _ in
            return WeatherProviderImp(networking: defaultNetworking())
        }
    }
}

extension WeatherProviderImp$ /* *** AUTOGENERATED *** */ {
    static var container: Container {
        return WeatherProviderImp_OpenWeatherMap$.container
    }
}
