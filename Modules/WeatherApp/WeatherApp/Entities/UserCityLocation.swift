//
//  UserCityLocation.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

enum UserCityLocation : Equatable {
    
    case cityId(String)
    case coordinate(CityCoordinate)
    case currentLocation
}
