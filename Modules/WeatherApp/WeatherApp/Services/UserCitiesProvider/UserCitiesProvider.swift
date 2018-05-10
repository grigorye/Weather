//
//  UserCitiesService.swift
//  WeatherApp
//
//  Created by Grigory Entin on 09/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift

protocol UserCitiesProvider {
    
    var userCities: Observable<[UserCity]> { get }

    func add(_: UserCity) throws
    func delete(_: UserCity) throws
}
