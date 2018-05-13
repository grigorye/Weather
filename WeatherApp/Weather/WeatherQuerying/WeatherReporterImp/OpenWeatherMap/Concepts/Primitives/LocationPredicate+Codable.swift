//
//  LocationPredicate+Codable.swift
//  WeatherApp/OpenWeatherMap
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

extension OpenWeatherMap$.LocationPredicate : Codable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .cityName(let cityName):
            try container.encode(cityName, forKey: .cityName)
        case .cityId(let cityId):
            try container.encode(cityId, forKey: .cityId)
        case .coordinate(let coordinate):
            try container.encode(coordinate, forKey: .coordinate)
        case .zipCode(let zipCode, countryCode: let countryCode):
            try container.encode(ZipCodeAndCountryCode(zipCode: zipCode, countryCode: countryCode), forKey: .zipCodeAndCountryCode)
        }
    }
    
    init(from decoder: Decoder) throws {
        enum DecodingError : Error {
            case unrecognized(dump: String)
        }
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let keys = values.allKeys
        guard keys.count == 1 else {
            throw DecodingError.unrecognized(dump: "\(values)")
        }
        
        let key = keys[0]
        self = try {
            switch key {
            case .cityName:
                let cityName = try values.decode(String.self, forKey: key)
                return .cityName(cityName)
            case .cityId:
                let cityId = try values.decode(Int.self, forKey: key)
                return .cityId(cityId)
            case .coordinate:
                let coordinate = try values.decode(Coordinate.self, forKey: key)
                return .coordinate(coordinate)
            case .zipCodeAndCountryCode:
                let value = try values.decode(ZipCodeAndCountryCode.self, forKey: key)
                return .zipCode(value.zipCode, countryCode: value.countryCode)
            }
            }()
    }
    
    struct ZipCodeAndCountryCode : Codable, Equatable {
        
        let zipCode: String
        let countryCode: String
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case coordinate
        case cityId
        case zipCodeAndCountryCode
        case cityName
    }
}
