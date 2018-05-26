//
//  UserCityInfo.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 19/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation.NSDate

struct UserCityInfo : Equatable {
    
    let dateAdded: Date
    let location: UserCityLocation
    let cityName: String
}
