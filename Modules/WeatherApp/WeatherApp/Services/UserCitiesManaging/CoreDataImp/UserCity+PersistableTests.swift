//
//  UserCity+PersistableTests.swift
//  WeatherAppTests
//
//  Created by Grigory Entin on 15/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import WeatherApp
import CoreData

class UserCity_PersistableTests : QuickSpec {
    
    override func spec() {
        context("when persisted") {
            let mom = NSPersistentContainer(name: "UserCities").managedObjectModel
            let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
            try! psc.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
            let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType).then {
                $0.persistentStoreCoordinator = psc
            }
            
            let userCity = UserCity(
                location: .cityId("2172797"),
                weather: WeatherInfo(
                    dateReceived: Date(),
                    temperature: Measurement(value: 0, unit: UnitTemperature.celsius),
                    cityName: "Cairns",
                    cityCoordinate: CityCoordinate(latitude: -16.92, longitude: 145.77)
                ),
                cityName: "Cairns",
                dateAdded: Date(),
                dateWeatherUpdated: Date(),
                dateWeatherRequested: Date(),
                errored: true,
                hasWeatherQueryInProgress: true
            )
            let persistentUserCity = PersistentUserCity(context: moc)
            userCity.update(persistentUserCity)
            it("should match original after recreated") {
                let updatedUserCity = UserCity(entity: persistentUserCity)
                expect(updatedUserCity) == userCity
            }
        }
    }
}
