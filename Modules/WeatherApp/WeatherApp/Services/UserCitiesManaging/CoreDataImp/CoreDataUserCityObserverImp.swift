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

func lastWeather(for userCity: UserCity, managedObjectContext: NSManagedObjectContext) -> LastWeather {
    let sortDescriptors = [
        NSSortDescriptor(key: #keyPath(PersistentUserCity.weatherStateVersion), ascending: true)
    ]
    
    typealias P = UserCity
    let persistable = userCity
    let predicate = NSPredicate(format: "%K = %@", P.primaryAttributeName, persistable.identity)
    
    return Observable.create { (observer) in
        observer.onNext(userCity.lastWeatherInfo)
        return managedObjectContext.rx
            .entities(UserCity.self, predicate: predicate, sortDescriptors: sortDescriptors)
            .subscribe(onNext: { (userCities) in
                guard userCities.count != 0 else {
                    observer.onCompleted()
                    return
                }
                assert(userCities.count == 1)
                let userCity = userCities.first!
                observer.onNext(userCity.lastWeatherInfo)
            })
    }.share(replay: 1, scope: .forever)
}

class UserCityCoreDataObserverImp : UserCityObserver {
    
    weak var delegate: UserCityObserverDelegate!
    let disposeBag = DisposeBag()
    
    init(userCity: UserCity, delegate: UserCityObserverDelegate, managedObjectContext: NSManagedObjectContext) {
        
        self.delegate = delegate
        
    }
}
