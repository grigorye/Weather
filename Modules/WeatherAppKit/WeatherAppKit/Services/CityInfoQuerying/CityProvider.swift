//
//  WeatherProvider.swift
//  WeatherApp
//
//  Created by Grigory Entin on 03/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Result

typealias CityQueryResult = Result<[CityInfo], AnyError>

protocol CityProvider {
    
    typealias DisposableQuery = AnyObject
    
    func queryCity(matching text: String, completion: @escaping (CityQueryResult) -> Void) -> DisposableQuery
}
