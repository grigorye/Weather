//
//  UserCityListItemView.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol UserCityListItemView : class {
    
    var model: UserCityListItemViewModel! { get set }
}

struct UserCityListItemViewModel {
    
    let cityName: String
    let temperature: String
    let subtitle: String
    
    let identifier: String
    let userInfo: Any!
}
