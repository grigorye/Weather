//
//  WeatherResponse.swift
//  OpenWeatherMapKit
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

public struct WeatherResponse : Decodable, Equatable {
    
    public let main: Main
    
    public struct Main : Decodable, Equatable {
        
        public let temp: Double
        
        public init(temp: Double) {
            self.temp = temp
        }
    }
    
    public init(main: Main) {
        self.main = main
    }
}
