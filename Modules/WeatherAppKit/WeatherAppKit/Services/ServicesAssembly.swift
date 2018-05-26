//
//  ServicesAssembly.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 25/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject

class ServicesAssembly : Assembly {
    
    func assemble(container: Container) {
        
        container.register(UserCitiesProvider.self, factory: { r in
            return defaultUserCitiesProvider()
        }).inObjectScope(.container)
        
        container.register(WeatherProvider.self, factory: { r in
            return defaultWeatherProvider()
        }).inObjectScope(.container)
        
        container.register(UserCityRefresher.self, factory: { r in
            return UserCityRefresherImp(
                userCitiesProvider: r.resolve(UserCitiesProvider.self)!,
                weatherProvider: r.resolve(WeatherProvider.self)!,
                locationService: r.resolve(LocationService.self)!
            )
        }).inObjectScope(.container)
        
        container.register(LocationService.self, factory: { r in
            return defaultLocationService
        }).inObjectScope(.container)
    }
}
