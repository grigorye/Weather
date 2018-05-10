//
//  UserCity+RxCoreData.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxCoreData

extension UserCity : Persistable {
    
    typealias T = PersistentUserCity

    static var entityName: String {
        return "PersistentUserCity"
    }
    
    static var primaryAttributeName: String {
        return #keyPath(PersistentUserCity.cityId)
    }
    
    var identity: String {
        return cityId
    }
    
    init(entity: PersistentUserCity) {
        cityId = entity.cityId!
        cityName = entity.cityName!
        dateAdded = entity.dateAdded!
        dateUpdated = entity.dateUpdated!
        userInfo = entity
    }
    
    func update(_ entity: PersistentUserCity) {
        assert((nil == userInfo) || (entity === (userInfo as! PersistentUserCity)))
        
        entity.cityId = cityId
        entity.cityName = cityName
        entity.dateAdded = dateAdded
        entity.dateUpdated = dateUpdated
        
        try! entity.managedObjectContext!.save()
    }
}
