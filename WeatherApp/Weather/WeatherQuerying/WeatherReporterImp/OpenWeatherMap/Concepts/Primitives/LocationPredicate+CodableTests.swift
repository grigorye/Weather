//
//  LocationPredicate+CodableTests.swift
//  WeatherApp/OpenWeatherMap
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import WeatherApp

class OpenWeatherMap_LocationPredicate_Codable_T : QuickSpec, OpenWeatherMap$$ {
    override func spec() {
        for (locationContext, locationPredicate) in locationPredicateSamplesWithContext {
            context(locationContext) {
                it("encoded should produce some data") {
                    let data = try! JSONEncoder().encode(locationPredicate)
                    expect(data) != Data()
                }
                it("encoded and decoded should produce original value") {
                    let data = try! JSONEncoder().encode(locationPredicate)
                    let decodedLocationPredicate = try! JSONDecoder().decode(LocationPredicate.self, from: data)
                    expect(locationPredicate) == decodedLocationPredicate
                }
            }
        }
    }
}

class OpenWeatherMap_LocationPredicate_Codable_ET : QuickSpec, OpenWeatherMap$$ {
    override func spec() {
        context("should error when") {
            it("decoded from empty data") {
                expect(expression: {
                    try JSONDecoder().decode(LocationPredicate.self, from: Data())
                }).to(throwError())
            }
            it("decoded from corrupted json") {
                let emptyJson = "{".data(using: .utf8)!
                expect(expression: {
                    try JSONDecoder().decode(LocationPredicate.self, from: emptyJson)
                }).to(throwError())
            }
            it("decoded from empty json") {
                let emptyJson = "{}".data(using: .utf8)!
                expect(expression: {
                    try JSONDecoder().decode(LocationPredicate.self, from: emptyJson)
                }).to(throwError())
            }
            it("decoded from badly typed json") {
                let json = "{\"cityId\": null}".data(using: .utf8)!
                expect(expression: {
                    try JSONDecoder().decode(LocationPredicate.self, from: json)
                }).to(throwError())
            }
        }
    }
}
