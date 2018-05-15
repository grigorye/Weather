//
//  UserCitiesService.swift
//  WeatherApp
//
//  Created by Grigory Entin on 09/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift

protocol UserCitiesProvider {
    
    var observableUserCities: Observable<[UserCity]> { get }
    var userCities: [UserCity] { get }
    
    func lastWeather(for: UserCity) -> LastWeather

    func add(_: UserCity) throws
    func delete(_: UserCity) throws
    
    func setWeatherQueryInProgress(for: [UserCity]) throws
    func setWeatherQueryCompleted(for: UserCity, with: WeatherQueryResult) throws
}
