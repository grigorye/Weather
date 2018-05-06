//
//  OpenWeatherMapNetworkingMoyaImp.swift
//  WeatherApp
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Moya
import Result

struct OpenWeatherMapNetworkingMoyaImp : OpenWeatherMapNetworking {
    
    typealias MoyaProvider = Moya.MoyaProvider<OpenWeatherMapMoyaTarget>
    
    let moyaProvider: MoyaProvider
    
    static func defaultMoyaProvider() -> MoyaProvider {
        let plugins: [Moya.PluginType] = [
            APIKeyPlugIn(apiKey: "529ff8bbf7587aa9d7038c970c075736"),
            NetworkLoggerPlugin(verbose: true, cURL: true)
        ]
        return MoyaProvider(plugins: plugins)
    }
    
    init(moyaProvider: MoyaProvider = defaultMoyaProvider()) {
        self.moyaProvider = moyaProvider
    }
    
    private func proceedWithRequestWeatherResponse(_ response: Moya.Response) throws -> OpenWeatherMapWeatherResponse {
        do {
            let response = try response.filter(statusCode: 200)
            return try response.map(OpenWeatherMapWeatherResponse.self)
        } catch MoyaError.statusCode(let moyaResponse) {
            throw Error.httpStatus(statusCode: moyaResponse.statusCode, response: moyaResponse.response)
        }
    }
    
    func queryWeather(for location: OpenWeatherMapLocationPredicate, completion: @escaping (WeatherQueryResult) -> Void) {
        moyaProvider.request(.weather(location: location)) { (moyaResult) in
            switch moyaResult {
            case .failure(let error):
                completion(.failure(.other(error)))
                return
            case .success(let response):
                let result = WeatherQueryResult() {
                    return try self.proceedWithRequestWeatherResponse(response)
                }
                completion(result)
            }
        }
    }
}
