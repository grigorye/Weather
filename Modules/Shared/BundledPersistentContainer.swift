//
//  BundledPersistentContainer.swift
//  GECoreData
//
//  Created by Grigory Entin on 07/05/2018.
//

import CoreData

class BundledPersistentContainer : NSPersistentContainer {
    
    override class func defaultDirectoryURL() -> URL {
        return Bundle.current.resourceURL!
    }
}
