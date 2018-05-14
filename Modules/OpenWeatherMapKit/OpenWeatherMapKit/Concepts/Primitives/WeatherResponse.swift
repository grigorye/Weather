//
//  WeatherResponse.swift
//  OpenWeatherMapKit
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

public struct WeatherResponse : Decodable, Equatable {
    
    public let main: Main
    public let sys: Sys
    public let name: String
    public let dt: Int

    public struct Main : Decodable, Equatable {
        
        public let temp: Double
        
        public init(temp: Double) {
            self.temp = temp
        }
    }
    
    public struct Sys : Decodable, Equatable {
        
        public let country: String?
        public let sunrise: Int
        public let sunset: Int

        public init(country: String?, sunrise: Int, sunset: Int) {
            self.country = country
            self.sunrise = sunrise
            self.sunset = sunset
        }
    }
    
    public init(main: Main, sys: Sys, name: String, dt: Int) {
        self.main = main
        self.sys = sys
        self.name = name
        self.dt = dt
    }
}
