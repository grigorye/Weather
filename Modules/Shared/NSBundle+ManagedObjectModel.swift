//
//  NSBundle+ManagedObjectModel.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 16/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import CoreData
import Foundation

extension Bundle {
    
    func managedObjectModel(withName modelName: String) -> NSManagedObjectModel! {
        let modelURL = self.url(forResource: modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)
    }
}
