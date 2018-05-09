//
//  PersistentCityInfos.swift
//  OpenWeatherMapKit/CityQueryingImp/CoreData/GeneratePersistentCityInfos
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import OpenWeatherMapKit
import Foundation
import CoreData

extension PersistentCityInfo {
    
    func setFrom(_ x: CityInfo) {
        id = Int64(x.id)
        coord_lat = x.coord.lat
        coord_lon = x.coord.lon
        name = x.name
        country = x.country
    }
}

func addCityInfos(_ cityInfos: [CityInfo], toPersistentStoreAt url: URL) throws {
    
    let bundle = Bundle(for: PersistentCityInfo.self)
    let momdURL = bundle.url(forResource: "CityInfos", withExtension: "momd")!
    let managedObjectModel = NSManagedObjectModel(contentsOf: momdURL)!
    let psc = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url)
    let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    moc.persistentStoreCoordinator = psc
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: PersistentCityInfo.fetchRequest())
    try moc.execute(deleteRequest)
    cityInfos.forEach {
        let managedCityInfo = PersistentCityInfo(context: moc)
        managedCityInfo.setFrom($0)
    }
    try moc.save()
}
