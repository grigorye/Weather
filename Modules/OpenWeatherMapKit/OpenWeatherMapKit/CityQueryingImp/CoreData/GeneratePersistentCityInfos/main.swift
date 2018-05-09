//
//  main.swift
//  OpenWeatherMapKit/CityQueryingImp/CoreData/GeneratePersistentCityInfos
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import OpenWeatherMapKit
import Foundation

do {
    let storeURL = URL(fileURLWithPath: CommandLine.arguments[1])
    print("Decoding..")
    let decoded = try decodeCityListJson()
    print("\(decoded.count) cities")
    print("Writing to \(storeURL)")
    try addCityInfos(decoded, toPersistentStoreAt: storeURL)
    if false {
        print("Vacuuming..")
        let vacuumArguments = [
            "sqlite3",
            storeURL.path,
            "vacuum"
        ]
        let vacuum = Process.launchedProcess(launchPath: "/usr/bin/env", arguments: vacuumArguments)
        vacuum.waitUntilExit()
    }
    print("Done")
} catch {
    print(error)
}
