//
//  DefaultCityProvider.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

func defaultCityProvider() -> CityProvider {
    return CityProviderImp$.container.resolve(CityProvider.self)!
}
