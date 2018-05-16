//
//  DefaultWeatherProvider.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

func defaultWeatherProvider() -> WeatherProvider {
    return WeatherProviderImp$.container.resolve(WeatherProvider.self)!
}
