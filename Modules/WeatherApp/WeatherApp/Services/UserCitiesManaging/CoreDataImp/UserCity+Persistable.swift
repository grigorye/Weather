//
//  UserCity+RxCoreData.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxCoreData

extension UserCity : Persistable {
    
    typealias T = PersistentUserCity

    static var entityName: String {
        return "PersistentUserCity"
    }
    
    static var primaryAttributeName: String {
        return #keyPath(PersistentUserCity.locationJson)
    }
    
    var identity: String {
        return location.asJson()
    }
    
    init(entity: PersistentUserCity) {
        self.location = entity.location
        self.cityName = entity.cityName!
        self.dateAdded = entity.dateAdded!
        self.weather = entity.weather
        self.dateWeatherUpdated = entity.dateWeatherUpdated
        self.dateWeatherRequested = entity.dateWeatherRequested
        self.errored = entity.errored
        self.weatherStateVersion = entity.weatherStateVersion
    }
    
    func update(_ entity: PersistentUserCity) {
        entity.location = location
        entity.cityName = cityName
        entity.dateAdded = dateAdded
        entity.weather = weather
        entity.dateWeatherUpdated = dateWeatherUpdated
        entity.dateWeatherRequested = dateWeatherRequested
        entity.errored = errored
        
        try! entity.managedObjectContext!.save()
    }
}
