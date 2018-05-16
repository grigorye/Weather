//
//  WeatherProvider.swift
//  WeatherApp
//
//  Created by Grigory Entin on 03/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Result

protocol WeatherProvider {
    
    func queryWeather(for locationPredicate: WeatherLocationPredicate, completion: @escaping (WeatherQueryResult) -> Void)
}
