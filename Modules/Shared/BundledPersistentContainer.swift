//
//  BundledPersistentContainer.swift
//  GECoreData
//
//  Created by Grigory Entin on 07/05/2018.
//

import CoreData

/// Provides access to persistent stores residing inside the *current* bundle. Should be compiled into the caller bundle.
class BundledPersistentContainer : NSPersistentContainer {
    
    override class func defaultDirectoryURL() -> URL {
        return Bundle.current.resourceURL!
    }
}
