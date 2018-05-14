//
//  LocationQuerying.swift
//  WeatherApp
//
//  Created by Grigory Entin on 14/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Result

protocol LocationService {
    
    func queryCurrentLocation(completionHandler: @escaping (Result<CityCoordinate, AnyError>) -> Void)
    
    var currentCoordinate: CityCoordinate? { get }
    
    var timeIntervalSinceLastUpdate: TimeInterval { get }
}
