//
//  UserCity+PersistableTests.swift
//  WeatherAppTests
//
//  Created by Grigory Entin on 15/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import WeatherAppKit
import CoreData

class UserCity_PersistableTests : QuickSpec {
    
    override func spec() {
        context("when persisted") {
            let mom = Bundle.current.managedObjectModel(withName: "UserCities")!
            let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
            try! psc.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
            let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType).then {
                $0.persistentStoreCoordinator = psc
            }
            
            let userCity = UserCityInfoAndLastWeatherInfo(
                userCityInfo: UserCityInfo(
                    dateAdded: Date(),
                    location: .cityId("2172797"),
                    cityName: "Cairns"
                ),
                lastWeatherInfo: LastWeatherInfo(
                    requestIsInProgress: true,
                    requestDate: Date(),
                    updateDate: Date(),
                    errored: true,
                    weather: WeatherInfo(
                        dateReceived: Date(),
                        temperature: Measurement(value: 0, unit: UnitTemperature.celsius),
                        cityName: "Cairns",
                        cityCoordinate: CityCoordinate(latitude: -16.92, longitude: 145.77)
                    )
                )
            )
            let persistentUserCity = PersistentUserCity(context: moc)
            userCity.update(persistentUserCity)
            it("should match original after recreated") {
                let updatedUserCity = UserCityInfoAndLastWeatherInfo(entity: persistentUserCity)
                expect(updatedUserCity) == userCity
                _ = moc // Keep moc around given that "it" is invoked after leaving the "context".
            }
        }
    }
}
