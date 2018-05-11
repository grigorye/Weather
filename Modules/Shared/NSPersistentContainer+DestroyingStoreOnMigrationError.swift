//
//  NSPersistentContainer+DestroyingStoreOnMigrationError.swift
//  WeatherApp
//
//  Created by Grigory Entin on 11/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import CoreData

extension NSPersistentContainer {
    
    func loadPersistentStoresDestroyingStoreOnMigrationError(completionHandler: @escaping (NSPersistentStoreDescription, Error?) -> Void) {
        var encounteredMigrationErrorsAndDestroyedStore = false
        var encounteredNonMigrationError = false
        loadPersistentStores { [persistentStoreCoordinator] (storeDescription, error) in
            guard let error = error else {
                completionHandler(storeDescription, nil)
                return
            }
            guard !encounteredNonMigrationError else {
                completionHandler(storeDescription, error)
                return
            }
            guard let cocoaError = error as? CocoaError, cocoaError.code == .migration else {
                encounteredNonMigrationError = true
                completionHandler(storeDescription, error)
                return
            }
            do {
                try persistentStoreCoordinator.destroyPersistentStore(at: storeDescription.url!, ofType: storeDescription.type, options: storeDescription.options)
            } catch {
                encounteredNonMigrationError = true
                completionHandler(storeDescription, error)
            }
            encounteredMigrationErrorsAndDestroyedStore = true
        }
        if !encounteredNonMigrationError && encounteredMigrationErrorsAndDestroyedStore {
            // Try again, this time not expecting migration errors, given that the problematic stores have been successfully destroyed.
            loadPersistentStores(completionHandler: completionHandler)
        }
    }
}
