//
//  APIKeyPlugin.swift
//  WeatherApp/OpenWeatherMap/NetworkingImp/Moya
//
//  Created by Grigory Entin on 05/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Moya

extension OpenWeatherMap_NetworkingImp_Moya$ {
    
    struct APIKeyPlugin : Moya.PluginType {
        
        let apiKey: String
        
        func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
            let url = request.url!
            let separator = url.query!.isEmpty ? "?" : "&"
            let updatedURLString = url.absoluteString + separator + "APPID=\(apiKey)"
            let updatedURL = URL(string: updatedURLString)
            
            var updatedRequest = request
            updatedRequest.url = updatedURL
            return updatedRequest
        }
    }
}

extension OpenWeatherMap_NetworkingImp_Moya$$ {
    typealias APIKeyPlugin = OpenWeatherMap_NetworkingImp_Moya$.APIKeyPlugin
}
