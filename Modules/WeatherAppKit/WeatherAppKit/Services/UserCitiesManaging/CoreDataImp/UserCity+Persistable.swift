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

extension UserCityInfoAndLastWeatherInfo : Persistable {
    
    typealias T = PersistentUserCity

    static var entityName: String {
        return "PersistentUserCity"
    }
    
    static var primaryAttributeName: String {
        return #keyPath(PersistentUserCity.locationJson)
    }
    
    var identity: String {
        return userCityIdentity(from: userCityInfo.location)
    }
    
    init(entity: PersistentUserCity) {
        self.userCityInfo = UserCityInfo(
            dateAdded: entity.dateAdded!,
            location: entity.location,
            cityName: entity.cityName!
        )
        self.lastWeatherInfo = LastWeatherInfo(
            requestIsInProgress: entity.hasWeatherQueryInProgress,
            requestDate: entity.dateWeatherRequested,
            updateDate: entity.dateWeatherUpdated,
            errored: entity.errored,
            weather: entity.weather
        )
    }
    
    func update(_ entity: PersistentUserCity) {
        userCityInfo.do {
            entity.dateAdded = $0.dateAdded
            entity.location = $0.location
            entity.cityName = $0.cityName
        }
        lastWeatherInfo.do {
            entity.weather = $0.weather
            entity.dateWeatherUpdated = $0.updateDate
            entity.dateWeatherRequested = $0.requestDate
            entity.errored = $0.errored
            entity.hasWeatherQueryInProgress = $0.requestIsInProgress
        }

        try! entity.managedObjectContext!.save()
    }
}
