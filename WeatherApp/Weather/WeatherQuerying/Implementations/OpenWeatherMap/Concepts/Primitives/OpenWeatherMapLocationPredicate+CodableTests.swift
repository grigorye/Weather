//
//  OpenWeatherMapLocationPredicateTests.swift
//  WeatherAppTests
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import WeatherApp

typealias Location = OpenWeatherMapLocationPredicate
typealias Coordinate = OpenWeatherMapLocationPredicate.Coordinate

class OpenWeatherMapLocationPredicate_Codable_ET : QuickSpec {
    override func spec() {
        context("decoded from empty data") {
            it("should error") {
                expect(expression: {
                    try JSONDecoder().decode(Location.self, from: Data())
                }).to(throwError())
            }
        }
        context("decoded from corrupted json") {
            it("should error") {
                let emptyJson = "{".data(using: .utf8)!
                expect(expression: {
                    try JSONDecoder().decode(Location.self, from: emptyJson)
                }).to(throwError())
            }
        }
        context("decoded from empty json") {
            it("should error") {
                let emptyJson = "{}".data(using: .utf8)!
                expect(expression: {
                    try JSONDecoder().decode(Location.self, from: emptyJson)
                }).to(throwError())
            }
        }
        context("decoded from badly typed json") {
            it("should error") {
                let json = "{\"cityId\": null}".data(using: .utf8)!
                expect(expression: {
                    try JSONDecoder().decode(Location.self, from: json)
                }).to(throwError())
            }
        }
    }
}

class OpenWeatherMapLocationPredicate_Codable_T : QuickSpec {
    override func spec() {
        let locationsWithContext = openWeatherMapLocationPredicateSamplesWithContext
        for (locationContext, location) in locationsWithContext {
            context(locationContext) {
                it("encoded should produce some data") {
                    let data = try! JSONEncoder().encode(location)
                    expect(data) != Data()
                }
                it("encoded and decoded should produce original value") {
                    let data = try! JSONEncoder().encode(location)
                    let decodedLocation = try! JSONDecoder().decode(Location.self, from: data)
                    expect(location) == decodedLocation
                }
            }
        }
    }
}
