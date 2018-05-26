//
//  UserCityInfoAndLastWeatherInfo.swift
//  WeatherApp
//
//  Created by Grigory Entin on 03/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

struct UserCityInfoAndLastWeatherInfo : Equatable {
    
    let userCityInfo: UserCityInfo
    let lastWeatherInfo: LastWeatherInfo
}

extension UserCityInfoAndLastWeatherInfo {
    
    init(with userCityInfo: UserCityInfo) {
        
        self.init(
            userCityInfo: userCityInfo,
            lastWeatherInfo: .init(requestIsInProgress: false, requestDate: nil, updateDate: nil, errored: false, weather: nil)
        )
    }
}
