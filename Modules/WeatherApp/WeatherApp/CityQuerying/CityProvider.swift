//
//  WeatherProvider.swift
//  WeatherApp
//
//  Created by Grigory Entin on 03/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Result

protocol CityProvider {
    
    typealias CityQueryResult = Result<[CityInfo], AnyError>
    typealias DisposableQuery = AnyObject
    
    func queryCity(matching text: String, completion: @escaping (CityQueryResult) -> Void) -> DisposableQuery
}
