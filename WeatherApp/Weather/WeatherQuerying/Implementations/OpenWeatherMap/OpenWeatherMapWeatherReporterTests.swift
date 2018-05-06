//
//  OpenWeatherMapWeatherReporterTests.swift
//  WeatherAppTests
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import WeatherApp

import Result

private let locationPredicate: WeatherLocationPredicate = .cityName("London")

class OpenWeatherMap_WeatherReporter_QueryWeather_T : QuickSpec {
    override func spec() {
        context("with good network") {
            var weatherReporter: WeatherReporter!
            beforeEach {
                struct NetworkingStub : OpenWeatherMapNetworking {
                    func queryWeather(for location: OpenWeatherMapLocationPredicate, completion: @escaping (WeatherQueryResult) -> Void) {
                        let response = OpenWeatherMapWeatherResponse(main: .init(temp: 50))
                        completion(.init(response))
                    }
                }
                weatherReporter = OpenWeatherMapWeatherReporter(networking: NetworkingStub())
            }
            for (locationPredicateContext, locationPredicate) in weatherLocationPredicateSamplesWithContext {
                context("when location is \(locationPredicateContext)") {
                    it("should succeed") {
                        var weatherQueryResult: WeatherReporter.WeatherQueryResult!
                        weatherReporter.queryWeather(for: locationPredicate, completion: { (result) in
                            weatherQueryResult = result
                        })
                        expect(weatherQueryResult).notTo(beNil())
                        expect(expression: {
                            try weatherQueryResult.dematerialize()
                        }).notTo(throwError())
                    }
                }
            }
        }
    }
}

class OpenWeatherMap_WeatherReporter_QueryWeather_ET : QuickSpec {
    override func spec() {
        context("with bad network") {
            var weatherReporter: WeatherReporter!
            beforeEach {
                enum FakeError : Error {
                    case unknownFailure
                }
                struct NetworkingStub : OpenWeatherMapNetworking {
                    func queryWeather(for location: OpenWeatherMapLocationPredicate, completion: @escaping (WeatherQueryResult) -> Void) {
                        completion(.failure(.other(FakeError.unknownFailure)))
                    }
                }
                weatherReporter = OpenWeatherMapWeatherReporter(networking: NetworkingStub())
            }
            for (locationPredicateContext, locationPredicate) in weatherLocationPredicateSamplesWithContext {
                context("when location is \(locationPredicateContext)") {
                    it("should error") {
                        var weatherQueryResult: WeatherReporter.WeatherQueryResult!
                        weatherReporter.queryWeather(for: locationPredicate, completion: { (result) in
                            weatherQueryResult = result
                        })
                        expect(weatherQueryResult).notTo(beNil())
                        expect(expression: {
                            try weatherQueryResult.dematerialize()
                        }).to(throwError())
                    }
                }
            }
        }
    }
}
