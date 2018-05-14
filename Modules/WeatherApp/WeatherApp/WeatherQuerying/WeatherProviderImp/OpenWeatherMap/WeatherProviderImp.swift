//
//  WeatherProviderImp.swift
//  WeatherApp/OpenWeatherMap
//
//  Created by Grigory Entin on 03/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import OpenWeatherMapKit
import Result

extension WeatherProviderImp_OpenWeatherMap$ {
    
    struct WeatherProviderImp : WeatherProvider {
        
        typealias Networking = OpenWeatherMapKit.Networking
        
        var networking: Networking!
        
        init(networking: Networking) {
            self.networking = networking
        }
                
        func queryWeather(for canonicPredicate: WeatherLocationPredicate, completion: @escaping (Result<WeatherInfo, AnyError>) -> Void) {
            let locationPredicate = LocationPredicate(canonicPredicate)
            networking.queryWeather(for: locationPredicate) { (result) in
                switch result {
                case .failure(let error):
                    completion(.failure(AnyError(error)))
                    return
                case .success(let networkWeatherInfo):
                    let temperature = Measurement(value: networkWeatherInfo.main.temp, unit: UnitTemperature.kelvin)
                    let weatherInfo = WeatherInfo(temperature: temperature, cityName: networkWeatherInfo.name)
                    completion(.success(weatherInfo))
                }
            }
        }
    }
}

extension WeatherProviderImp_OpenWeatherMap$$ /* *** AUTOGENERATED *** */ {
    typealias WeatherProviderImp = WeatherProviderImp_OpenWeatherMap$.WeatherProviderImp
}
