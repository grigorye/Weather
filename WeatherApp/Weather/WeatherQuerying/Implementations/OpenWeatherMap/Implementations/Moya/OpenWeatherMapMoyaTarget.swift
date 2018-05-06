//
//  OpenWeatherMapMoyaTarget.swift
//  WeatherApp
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Moya

enum OpenWeatherMapMoyaTarget {
    case weather(location: OpenWeatherMapLocationPredicate)
}

extension OpenWeatherMapMoyaTarget : Moya.TargetType {
    
    var baseURL: URL { return URL(string: "https://api.openweathermap.org")!}
    
    var path: String {
        switch self {
        case .weather:
            return "data/2.5/weather"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .weather:
            return .get
        }
    }
    
    var sampleData: Data {
        let bundle = Bundle.main
        let dataURL: URL = {
            switch self {
            case .weather:
                return bundle.url(forResource: "OpenWeatherMapWeatherResponseSample", withExtension: "json")!
            }
        }()
        return try! Data(contentsOf: dataURL)
    }
    
    var task: Moya.Task {
        switch self {
        case .weather(let locationPredicate):
            let parameters: [String : Any] = {
                switch locationPredicate {
                case .cityName(let cityName):
                    return [
                        "q":cityName
                    ]
                case .cityId(let cityId):
                    return [
                        "id":cityId
                    ]
                case .zipCode(let zipCode, let countryCode):
                    return [
                        "zip": "\(zipCode),\(countryCode)"
                    ]
                case .coordinate(let coordinate):
                    return [
                        "lat":coordinate.lat,
                        "lon":coordinate.lon
                    ]
                }
            }()
            return .requestCompositeData(bodyData: Data(), urlParameters: parameters)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
