//
//  UserCityRefresher.swift
//  WeatherApp
//
//  Created by Grigory Entin on 15/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol UserCityRefresher {
    
    func refreshAsNecessary(_: [UserCity])
    func clearRefreshingAsNecessary(for: [UserCity])
}
