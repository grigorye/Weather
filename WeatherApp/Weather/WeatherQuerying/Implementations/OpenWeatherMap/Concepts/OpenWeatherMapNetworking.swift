//
//  OpenWeatherMapNetworking.swift
//  WeatherApp
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Result

enum OpenWeatherMapNetworkingError : Swift.Error {
    case httpStatus(statusCode: Int, response: URLResponse?)
    case other(Error)
}

protocol OpenWeatherMapNetworking {

    typealias Error = OpenWeatherMapNetworkingError
    typealias WeatherQueryResult = Result<OpenWeatherMapWeatherResponse, Error>
    
    func queryWeather(for location: OpenWeatherMapLocationPredicate, completion: @escaping (WeatherQueryResult) -> Void)
}
