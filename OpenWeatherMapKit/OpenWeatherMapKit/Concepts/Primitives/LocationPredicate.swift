//
//  LocationPredicate.swift
//  OpenWeatherMapKit
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

public enum LocationPredicate : Equatable {
    
    case cityName(String)
    case cityId(Int)
    case coordinate(Coordinate)
    case zipCode(String, countryCode: String)
    
    public struct Coordinate : Codable, Equatable {
        
        public let lat: Double
        public let lon: Double
        
        public init(lat: Double, lon: Double) {
            self.lat = lat
            self.lon = lon
        }
    }
}
