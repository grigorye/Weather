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
    
    lazy var userCities: Observable<[UserCity]> =
        managedObjectContext.rx
            .entities(UserCity.self, sortDescriptors: [NSSortDescriptor(key: #keyPath(PersistentUserCity.dateAdded), ascending: true)])
    
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
