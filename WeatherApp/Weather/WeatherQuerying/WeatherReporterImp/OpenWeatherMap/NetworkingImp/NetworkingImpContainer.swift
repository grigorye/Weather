//
//  NetworkingImpContainer.swift
//  WeatherApp/OpenWeatherMap/NetworkingImp
//
//  Created by Grigory Entin on 05/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject

extension OpenWeatherMap_NetworkingImp_Moya$ {
    
    static var container: Container = {
        $0.register(Networking.self) { _ in
            MoyaNetworking()
        }
        return $0
    } (Container())
}

extension OpenWeatherMap_NetworkingImp$$ {
    var container: Container {
        return OpenWeatherMap_NetworkingImp_Moya$.container
    }
}
