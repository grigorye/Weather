//
//  MoyaNetworking.swift
//  WeatherApp/OpenWeatherMap/NetworkingImp/Moya
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Moya

extension OpenWeatherMap_NetworkingImp_Moya$ {
    
    struct MoyaNetworking : Networking {
        
        typealias MoyaProvider = Moya.MoyaProvider<MoyaTarget>
        
        let moyaProvider: MoyaProvider
        
        static func defaultMoyaProvider() -> MoyaProvider {
            let plugins: [Moya.PluginType] = [
                APIKeyPlugin(apiKey: "529ff8bbf7587aa9d7038c970c075736"),
                NetworkLoggerPlugin(verbose: true, cURL: true)
            ]
            return MoyaProvider(plugins: plugins)
        }
        
        init(moyaProvider: MoyaProvider = defaultMoyaProvider()) {
            self.moyaProvider = moyaProvider
        }
        
        private func proceedWithRequestWeatherResponse(_ response: Moya.Response) throws -> WeatherResponse {
            do {
                let response = try response.filter(statusCode: 200)
                return try response.map(WeatherResponse.self)
            } catch MoyaError.statusCode(let moyaResponse) {
                throw NetworkingError.httpStatus(statusCode: moyaResponse.statusCode, response: moyaResponse.response)
            }
        }
        
        func queryWeather(for locationPredicate: LocationPredicate, completion: @escaping (WeatherQueryResult) -> Void) {
            moyaProvider.request(.weather(for: locationPredicate)) { (moyaResult) in
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
}

extension OpenWeatherMap_NetworkingImp_Moya$$ {
    typealias MoyaNetworking = OpenWeatherMap_NetworkingImp_Moya$.MoyaNetworking
}
