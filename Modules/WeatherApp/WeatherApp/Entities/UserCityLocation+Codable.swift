//
//  UserCityLocation+Codable.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

extension UserCityLocation : Codable {
    
    // https://medium.com/@hllmandel/codable-enum-with-associated-values-swift-4-e7d75d6f4370
    
    private enum Base : String, Codable {
        case cityId, coordinate, currentLocation
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let base = try container.decode(Base.self, forKey: .base)
        
        switch base {
        case .cityId:
            let cityId = try container.decode(CityId.self, forKey: .value)
            self = .cityId(cityId)
        case .coordinate:
            let coordinate = try container.decode(CityCoordinate.self, forKey: .value)
            self = .coordinate(coordinate)
        case .currentLocation:
            self = .currentLocation
        }
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        let base: Base
        switch self {
        case .cityId:
            base = .cityId
        case .coordinate:
            base = .coordinate
        case .currentLocation:
            base = .currentLocation
        }
        
        try container.encode(base, forKey: .base)
        
        switch self {
        case .cityId(let cityId):
            try container.encode(cityId, forKey: .value)
        case .coordinate(let coordinate):
            try container.encode(coordinate, forKey: .value)
        case .currentLocation:
            ()
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case base
        case value
    }
}
