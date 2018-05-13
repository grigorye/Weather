//
//  WeatherProvider+BatchRequestsImp.swift
//  WeatherApp
//
//  Created by Grigory Entin on 11/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Result
import Foundation

var defaultCurrentLocation: CityCoordinate {
    return .init(latitude: 52.3545653, longitude: 4.7585394)
}

extension UserCityLocation {
    
    var weatherLocationPredicate: WeatherLocationPredicate {
        switch self {
        case .cityId(let cityId):
            return .cityId(cityId)
        case .coordinate(let coordinate):
            return .coordinate(coordinate)
        case .currentLocation:
            return .coordinate(defaultCurrentLocation)
        }
    }
}

extension WeatherProvider {
    
    /// Quick hack due to no implemented batch weather requests.
    func queryWeather(for locations: [UserCityLocation], completion: @escaping ([Result<WeatherInfo, AnyError>]) -> Void) {
        
        let completionGroup = DispatchGroup()
        let resultQueue = DispatchQueue(label: "")
        var enumeratedResults: [Int : Result<WeatherInfo, AnyError>] = [:]
        for (i, location) in locations.enumerated() {
            completionGroup.enter()
            let locationPredicate = location.weatherLocationPredicate
            queryWeather(for: locationPredicate, completion: { (result) in
                resultQueue.async {
                    enumeratedResults[i] = result
                    completionGroup.leave()
                }
            })
        }
        DispatchQueue.global().async {
            completionGroup.wait()
            let results = (0..<enumeratedResults.count).map {
                enumeratedResults[$0]!
            }
            completion(results)
        }
    }
}
