//
//  UserCityCoreDataObserverImp.swift
//  WeatherApp
//
//  Created by Grigory Entin on 15/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxCoreData
import RxSwift
import CoreData

extension PersistentUserCity {
    static let namesOfComponentsOfLastWeather: Set<String> = [
        #keyPath(dateWeatherRequested),
        #keyPath(dateWeatherUpdated),
        #keyPath(errored),
        #keyPath(weatherJson),
        #keyPath(hasWeatherQueryInProgress)
    ]
}

class UserCityCoreDataObserverImp : UserCityObserver {
    
    weak var delegate: UserCityObserverDelegate!
    let disposeBag = DisposeBag()
    
    init(userCity: UserCity, delegate: UserCityObserverDelegate, managedObjectContext: NSManagedObjectContext) {
        
        self.delegate = delegate
        
    }
}
