//
//  Networking.swift
//  WeatherApp/OpenWeatherMap
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

public protocol Networking {

    func queryWeather(for locationPredicate: LocationPredicate, completion: @escaping (WeatherQueryResult) -> Void)
}
