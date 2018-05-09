//
//  PersistentCityInfo.swift
//  OpenWeatherMapKit/CityQueryingImp/CoreData
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

extension CityInfo {
    
    init(from x: PersistentCityInfo) {
        id = Int(x.id)
        coord = .init(lat: x.coord_lat, lon: x.coord_lon)
        name = x.name!
        country = x.country!
    }
}
