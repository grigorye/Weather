//
//  UserCity.swift
//  WeatherApp
//
//  Created by Grigory Entin on 03/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation.NSDate

struct UserCity {

    let location: UserCityLocation
    
    let cityName: String
    let dateAdded: Date
    let dateUpdated: Date

    let userInfo: Any!
}

extension UserCity {
    
    init(with location: UserCityLocation, cityName: String) {
        
        self.init(location: location, cityName: cityName, dateAdded: .init(), dateUpdated: .distantPast, userInfo: nil)
    }
}
