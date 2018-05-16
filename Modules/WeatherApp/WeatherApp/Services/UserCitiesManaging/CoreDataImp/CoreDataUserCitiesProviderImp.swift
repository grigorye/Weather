//
//  CoreDataUserCitiesImp.swift
//  WeatherApp
//
//  Created by Grigory Entin on 09/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift
import RxCoreData
import CoreData

class CoreDataUserCitiesProvider : UserCitiesProvider {
    
    // MARK: - <UserCitiesProvider>
    
    func add(_ userCity: UserCity) throws {
        try managedObjectContext.rx.update(userCity)
    }
    
    func delete(_ userCity: UserCity) throws {
        try managedObjectContext.rx.delete(userCity)
    }
    
    func setWeatherQueryInProgress(for userCities: [UserCity]) throws {
        try userCities.forEach {
            try self.setWeatherQueryInProgress(for: $0)
        }
    }
    
    func setWeatherQueryInProgress(for userCity: UserCity) throws {
        let now = Date()
        let updatedUserCity = userCity.with {
            $0.dateWeatherRequested = now
            $0.hasWeatherQueryInProgress = true
        }
        try managedObjectContext.rx.update(updatedUserCity)
    }
    
    func setWeatherQueryCompleted(for userCity: UserCity, with result: WeatherQueryResult) throws {
        let now = Date()
        let updatedUserCity = userCity.with {
            $0.dateWeatherUpdated = now
            $0.hasWeatherQueryInProgress = false
            switch result {
            case .failure(let error):
                print(error)
                $0.errored = true // (and retain old weather)
            case .success(let weatherInfo):
                $0.errored = false
                $0.weather = weatherInfo
            }
        }
        assert(!userCity.hasWeatherQueryInProgress)
        try managedObjectContext.rx.update(updatedUserCity)
    }

    lazy var observableUserCities: Observable<[UserCity]> = {
        let sortDescriptors = [
            NSSortDescriptor(key: #keyPath(PersistentUserCity.dateAdded), ascending: true)
        ]
        return
            managedObjectContext.rx
                .entities(UserCity.self, sortDescriptors: sortDescriptors)
                .share(replay: 1, scope: .forever)
    }()
    
    func lastWeather(for userCity: UserCity) -> LastWeather {
        return WeatherApp.lastWeather(for: userCity, managedObjectContext: self.managedObjectContext)
    }
    
    // MARK: -
    
    private lazy var persistentContainer = NSPersistentContainer(name: "UserCities").then { (container) in
        container.loadPersistentStoresDestroyingStoreOnMigrationError { (storeDescription, error) in
            if let error = error {
                fatalError("error: \(error), persistentStore: \(storeDescription)")
            }
        }
    }
    
    private lazy var managedObjectContext = persistentContainer.viewContext
    
    init() {}
    deinit {()}
}
