//
//  CityProviderImpContainer.swift
//  WeatherApp/CityProviderImp
//
//  Created by Grigory Entin on 05/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import OpenWeatherMapKit
import Swinject

extension CityProviderImp_OpenWeatherMap$ {
    
    static var container = Container().then {
        $0.register(CityProvider.self) { _ in
            return CityProviderImp(cityQuerying: defaultCityQuerying())
        }
    }
}

extension CityProviderImp$ /* *** AUTOGENERATED *** */ {
    static var container: Container {
        return CityProviderImp_OpenWeatherMap$.container
    }
}
