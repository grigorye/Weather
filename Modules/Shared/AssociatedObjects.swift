//
//  AssociatedObjects.swift
//  GEBase
//
//  Created by Grigory Entin on 03.04.16.
//  Copyright © 2016 Grigory Entin. All rights reserved.
//

import ObjectiveC.runtime

public func associatedObjectRegeneratedAsNecessary<T>(obj: AnyObject!, key: UnsafeRawPointer, generator: @autoclosure () -> T) -> T {
    
	guard let existingObject = objc_getAssociatedObject(obj, key) as! T? else {
		let newObject = generator()
		objc_setAssociatedObject(obj, key, newObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		return newObject
	}
    
	return existingObject
}
