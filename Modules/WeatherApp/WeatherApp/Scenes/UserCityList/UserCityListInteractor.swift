//
//  UserCityListInteractor.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxCocoa
import RxSwift
import Result
import Then

extension Array : Then {}

protocol UserCityListInteractor {
    
    var observableUserCities: Observable<[UserCity]> { get }
    
    func lastWeather(for: UserCity) -> LastWeather
    
    var userCities: [UserCity] { get }

    func refreshUserCities()
    
    func delete(_: UserCity)
}

class UserCityListInteractorImp : UserCityListInteractor {
    
    let userCitiesProvider: UserCitiesProvider
    let weatherProvider: WeatherProvider
    let userCityRefresher: UserCityRefresher
    
    deinit {()}
    
    init(userCitiesProvider: UserCitiesProvider, weatherProvider: WeatherProvider, userCityRefresher: UserCityRefresher) {
        
        self.userCitiesProvider = userCitiesProvider
        self.weatherProvider = weatherProvider
        self.userCityRefresher = userCityRefresher
    }
}

extension UserCityLocation {
    var isCurrentLocation: Bool {
        switch self {
        case .currentLocation:
            return true
        default:
            return false
        }
    }
}

extension UserCityListInteractorImp {
    
    // MARK: - <UserCityListInteractor>
    
    var observableUserCities: Observable<[UserCity]> {
        return userCitiesProvider.observableUserCities
    }
    
    var userCities: [UserCity] {
        return userCitiesProvider.userCities
    }

    func lastWeather(for userCity: UserCity) -> LastWeather {
        return userCitiesProvider.lastWeather(for: userCity)
    }
    
    func refreshUserCities() {
        self.userCityRefresher.refreshUserCitiesAsNecessary(self.userCities)
    }
    
    func delete(_ userCity: UserCity) {
        try! userCitiesProvider.delete(userCity)
    }
}
