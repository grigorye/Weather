//
//  WeatherProvider+BatchRequestsImp.swift
//  WeatherApp
//
//  Created by Grigory Entin on 11/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Result
import Foundation

extension WeatherProvider {
    
    /// Quick hack due to no implemented batch weather requests.
    func queryWeather(forCityIds cityIds: [String], completion: @escaping ([Result<WeatherInfo, AnyError>]) -> Void) {
        
        let completionGroup = DispatchGroup()
        let resultQueue = DispatchQueue(label: "")
        var enumeratedResults: [Int : Result<WeatherInfo, AnyError>] = [:]
        for (i, cityId) in cityIds.enumerated() {
            completionGroup.enter()
            queryWeather(for: .cityId(cityId), completion: { (result) in
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
