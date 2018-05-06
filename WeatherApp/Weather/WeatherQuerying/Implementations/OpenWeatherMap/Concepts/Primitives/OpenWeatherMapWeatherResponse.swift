//
//  OpenWeatherMapWeatherResponse.swift
//  WeatherApp
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

struct OpenWeatherMapWeatherResponse : Decodable, Equatable {
    
    let main: Main
    
    struct Main : Decodable, Equatable {
        let temp: Double
    }
}
