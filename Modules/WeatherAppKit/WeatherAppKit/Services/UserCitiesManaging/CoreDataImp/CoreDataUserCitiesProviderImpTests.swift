//
//  CoreDataUserCitiesProviderImpTests.swift
//  WeatherAppKitTests
//
//  Created by Grigory Entin on 19/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import WeatherAppKit
import CoreData

func coreDataUserCitiesImpTestProvider() -> UserCitiesProvider {
    let mom = CoreDataUserCitiesProvider.managedObjectModel
    let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
    try! psc.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
    let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType).then {
        $0.persistentStoreCoordinator = psc
    }
    return CoreDataUserCitiesProvider(with: moc)
}

class CoreDataUserCitiesProviderImpTests : QuickSpec {
    
    override func spec() {
        
        context("") {
            it("might be constructed") {
                _ = CoreDataUserCitiesProvider()
            }
        }
    }
}
