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
    
    var observableUserCityInfos: Observable<[UserCityInfo]> { get }
    
    func weatherIsEverQueried(for: UserCityLocation) -> Bool
    func lastWeather(for: UserCityLocation) -> LastWeather
    
    func refreshUserCityLocations()
    func refreshUserCityLocations(_: [UserCityLocation])
    func clearRefreshingForUserCityLocations()
    
    func delete(_: UserCityLocation)
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
    
    var observableUserCityInfos: Observable<[UserCityInfo]> {
        return userCitiesProvider.observableUserCityInfos
    }
    
    func weatherIsEverQueried(for location: UserCityLocation) -> Bool {
        return try! userCitiesProvider.weatherIsEverQueried(for: location)
    }
    
    func lastWeather(for location: UserCityLocation) -> LastWeather {
        return userCitiesProvider.lastWeather(for: location)
    }
    
    func refreshUserCityLocations() {
        _ = observableUserCityInfos.take(1).subscribe(onNext: { [userCityRefresher] (userCityInfos) in
            let locations = userCityInfos.map { $0.location }
            userCityRefresher.refreshAsNecessary(weatherFor: locations)
        })
    }
    
    func refreshUserCityLocations(_ locations: [UserCityLocation]) {
        userCityRefresher.refreshAsNecessary(weatherFor: locations)
    }

    func clearRefreshingForUserCityLocations() {
        _ = observableUserCityInfos.take(1).subscribe(onNext: { [userCityRefresher] (userCityInfos) in
            let locations = userCityInfos.map { $0.location }
            userCityRefresher.clearWeatherRefreshingAsNecessary(for: locations)
        })
    }

    func delete(_ location: UserCityLocation) {
        try! userCitiesProvider.deleteUserCity(for: location)
    }
}
