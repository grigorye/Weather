//
//  CityInfo.swift
//  OpenWeatherMapKit
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

public struct CityInfo : Codable {
    
    public let id: Int
    public let name: String
    public let country: String
    public let coord: Coordinate
}
