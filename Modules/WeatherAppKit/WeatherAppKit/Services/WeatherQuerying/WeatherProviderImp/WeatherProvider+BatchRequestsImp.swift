//
//  WeatherProvider+BatchRequestsImp.swift
//  WeatherApp
//
//  Created by Grigory Entin on 11/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Result
import Foundation

extension UserCityLocation {
    
    var weatherLocationPredicate: WeatherLocationPredicate {
        switch self {
        case .cityId(let cityId):
            return .cityId(cityId)
        case .coordinate(let coordinate):
            return .coordinate(coordinate)
        case .currentLocation:
            preconditionFailure()
        }
    }
}

extension WeatherProvider {
    
    /// Quick hack due to no implemented batch weather requests.
    func queryWeather(for locationPredicates: [WeatherLocationPredicate], completion: @escaping ([WeatherQueryResult]) -> Void) {
        
        let completionGroup = DispatchGroup()
        let resultQueue = DispatchQueue(label: "")
        var enumeratedResults: [Int : Result<WeatherInfo, AnyError>] = [:]
        for (i, locationPredicate) in locationPredicates.enumerated() {
            completionGroup.enter()
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
