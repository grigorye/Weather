//
//  UserCitiesService.swift
//  WeatherApp
//
//  Created by Grigory Entin on 09/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift

protocol UserCitiesProvider {
    
    var observableUserCityInfos: Observable<[UserCityInfo]> { get }
    
    func lastWeather(for: UserCityLocation) -> LastWeather

    func addUserCity(with: UserCityInfo) throws
    func deleteUserCity(for: UserCityLocation) throws
    
    func weatherIsEverQueried(for: UserCityLocation) throws -> Bool
    func hasWeatherQueryInProgress(for: UserCityLocation) throws -> Bool 
    func setWeatherQueryInProgress(for: UserCityLocation) throws
    func setWeatherQueryCompleted(for: UserCityLocation, with: WeatherQueryResult) throws
}
