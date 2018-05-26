//
//  NSObject+RetainedObjects.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation.NSObject

private var retainedObjectsAssoc: Void?

extension NSObjectProtocol {
    
    private var retainedObjects: NSMutableArray {
        return associatedObjectRegeneratedAsNecessary(obj: self, key: &retainedObjectsAssoc, generator: [])
    }
    
    func retainObject(_ object: AnyObject) {
        retainedObjects.add(object)
    }
}

func objectsRetained(in owner: AnyObject) -> NSMutableArray {
    return associatedObjectRegeneratedAsNecessary(obj: owner, key: &retainedObjectsAssoc, generator: [])
}

func retain(_ object: AnyObject, in owner: AnyObject) {
    objectsRetained(in: owner).add(object)
}
