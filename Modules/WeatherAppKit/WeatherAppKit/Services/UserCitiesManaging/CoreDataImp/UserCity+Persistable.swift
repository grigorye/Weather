//
//  UserCity+RxCoreData.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxCoreData

func userCityIdentity(from location: UserCityLocation) -> String {
    return location.asJson()
}

extension UserCity : Persistable {
    
    typealias T = PersistentUserCity

    static var entityName: String {
        return "PersistentUserCity"
    }
    
    static var primaryAttributeName: String {
        return #keyPath(PersistentUserCity.locationJson)
    }
    
    var identity: String {
        return userCityIdentity(from: location)
    }
    
    init(entity: PersistentUserCity) {
        self.location = entity.location
        self.cityName = entity.cityName!
        self.dateAdded = entity.dateAdded!
        self.weather = entity.weather
        self.dateWeatherUpdated = entity.dateWeatherUpdated
        self.dateWeatherRequested = entity.dateWeatherRequested
        self.errored = entity.errored
        self.hasWeatherQueryInProgress = entity.hasWeatherQueryInProgress
    }
    
    func update(_ entity: PersistentUserCity) {
        entity.location = location
        entity.cityName = cityName
        entity.dateAdded = dateAdded
        entity.weather = weather
        entity.dateWeatherUpdated = dateWeatherUpdated
        entity.dateWeatherRequested = dateWeatherRequested
        entity.errored = errored
        entity.hasWeatherQueryInProgress = hasWeatherQueryInProgress

        try! entity.managedObjectContext!.save()
    }
}
