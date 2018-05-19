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
    
    func addUserCity(with userCityInfo: UserCityInfo) throws {
        let userCity = UserCity(with: userCityInfo.location, cityName: userCityInfo.cityName)
        try managedObjectContext.rx.update(userCity)
    }
    
    func deleteUserCity(for location: UserCityLocation) throws {
        let userCity = try persistentUserCityFor(location)!
        managedObjectContext.delete(userCity)
        try managedObjectContext.save()
    }
    
    func hasWeatherQueryInProgress(for location: UserCityLocation) throws -> Bool {
        let userCity = try persistentUserCityFor(location)!
        return userCity.hasWeatherQueryInProgress
    }
    
    func setWeatherQueryInProgress(for location: UserCityLocation) throws {
        let now = Date()
        let userCity = try persistentUserCityFor(location)!
        userCity.do {
            $0.dateWeatherRequested = now
            $0.hasWeatherQueryInProgress = true
        }
        try managedObjectContext.save()
    }

    private func persistentUserCityFor(_ location: UserCityLocation) throws -> PersistentUserCity? {
        
        typealias P = UserCity
        let identity = userCityIdentity(from: location)
        let predicate = NSPredicate(format: "%K = %@", UserCity.primaryAttributeName, identity)
        
        let fetchRequest: NSFetchRequest<PersistentUserCity> = PersistentUserCity.fetchRequest().then {
            $0.predicate = predicate
        }
        let persistentUserCities = try managedObjectContext.fetch(fetchRequest)
        assert(persistentUserCities.count <= 1)
        let persistentUserCity = persistentUserCities.first
        return persistentUserCity
    }
    
    func setWeatherQueryCompleted(for location: UserCityLocation, with result: WeatherQueryResult) throws {
        let now = Date()
        let userCity = try persistentUserCityFor(location)!
        userCity.do {
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
        try managedObjectContext.save()
    }

    lazy var observableUserCityInfos: Observable<[UserCityInfo]> = {
        let sortDescriptors = [
            NSSortDescriptor(key: #keyPath(PersistentUserCity.dateAdded), ascending: true)
        ]
        return
            managedObjectContext.rx
                .entities(UserCity.self, sortDescriptors: sortDescriptors)
                .map({ (userCities) in
                    userCities.map { UserCityInfo(location: $0.location, cityName: $0.cityName) }
                })
                .share(replay: 1, scope: .forever)
    }()
    
    func weatherIsEverQueried(for location: UserCityLocation) throws -> Bool {
        let userCity = try persistentUserCityFor(location)!
        guard nil == userCity.dateWeatherRequested else {
            return true
        }
        guard nil == userCity.dateWeatherUpdated else {
            return true
        }
        return false
    }
    
    func lastWeather(for location: UserCityLocation) -> LastWeather {
        let sortDescriptors = PersistentUserCity.namesOfComponentsOfLastWeather.map {
            NSSortDescriptor(key: $0, ascending: true)
        }
        
        let predicate = NSPredicate(format: "%K = %@", UserCity.primaryAttributeName, userCityIdentity(from: location))
        
        return Observable.create { [unowned self, managedObjectContext] (observer) in
            let persistentUserCity = try! self.persistentUserCityFor(location)!
            let userCity = UserCity(entity: persistentUserCity)
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
    
    // MARK: -
    
    private(set) public static var managedObjectModel = Bundle.current.managedObjectModel(withName: "UserCities")!
    
    private var managedObjectContext: NSManagedObjectContext
    
    convenience init() {
        let persistentContainer = NSPersistentContainer(name: "UserCities", managedObjectModel: type(of: self).managedObjectModel).then { (container) in
            container.loadPersistentStoresDestroyingStoreOnMigrationError { (storeDescription, error) in
                if let error = error {
                    fatalError("error: \(error), persistentStore: \(storeDescription)")
                }
            }
        }
        self.init(with: persistentContainer.viewContext)
    }
    
    init(with managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    deinit {()}
}
