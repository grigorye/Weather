//
//  CityQuerying.swift
//  OpenWeatherMapKit
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

public protocol CityQuerying {
    
    typealias DisposableQuery = AnyObject
    
    func queryCity(matching text: String, completion: @escaping (CityQueryResult) -> Void) -> DisposableQuery
}
