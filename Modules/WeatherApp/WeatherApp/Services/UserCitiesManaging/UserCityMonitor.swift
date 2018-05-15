//
//  UserCityObserver.swift
//  WeatherApp
//
//  Created by Grigory Entin on 15/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol UserCityObserverDelegate : class {
    
    func userCityDidChange(userCity: UserCity)
}

protocol UserCityObserver {
    
    var delegate: UserCityObserverDelegate! { get set }
}
