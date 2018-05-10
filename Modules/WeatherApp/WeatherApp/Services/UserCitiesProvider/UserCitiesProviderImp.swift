//
//  UserCitiesProviderImp.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

let defaultUserCitiesProviderImp: UserCitiesProvider = CoreDataUserCitiesProvider()

func defaultUserCitiesProvider() -> UserCitiesProvider {
    return defaultUserCitiesProviderImp
}
