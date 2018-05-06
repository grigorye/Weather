//
//  OpenWeatherMapWeatherReporter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 03/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Result

struct OpenWeatherMapWeatherReporter : WeatherReporter {
    
    var networking: OpenWeatherMapNetworking!
    
    init(networking: OpenWeatherMapNetworking) {
        self.networking = networking
    }
    
    func queryWeather(for locationPredicate: WeatherLocationPredicate, completion: @escaping (Result<WeatherInfo, AnyError>) -> Void) {
        let locationPredicate = OpenWeatherMapLocationPredicate(locationPredicate)
        networking.queryWeather(for: locationPredicate) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(AnyError(error)))
                return
            case .success(let networkWeatherInfo):
                let temperature = Measurement(value: networkWeatherInfo.main.temp, unit: UnitTemperature.celsius)
                let weatherInfo = WeatherInfo(temperature: temperature)
                completion(.success(weatherInfo))
            }
        }
    }
}
