//
//  PersistentUserCity+Location.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

extension PersistentUserCity {
    
    var location: UserCityLocation {
        set {
            self.locationJson = newValue.asJson()
        }
        get {
            return try! .init(fromJson: locationJson!)
        }
    }
    
    var weather: WeatherInfo? {
        set {
            self.weatherJson = newValue?.asJson()
        }
        get {
            return weatherJson.flatMap { try! .init(fromJson: $0) }
        }
    }
}
