//
//  WeatherReporter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 03/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Result

protocol WeatherReporter {
    
    typealias WeatherQueryResult = Result<WeatherInfo, AnyError>
    
    func queryWeather(for locationPredicate: WeatherLocationPredicate, completion: @escaping (WeatherQueryResult) -> Void)
}
