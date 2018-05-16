//
//  WeatherProviderImpTests.swift
//  WeatherApp/OpenWeatherMap
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import WeatherAppKit
import OpenWeatherMapKit
import Result

class WeatherProviderImp_OpenWeatherMap_WeatherProviderImp_QueryWeather_T : QuickSpec, WeatherProviderImp_OpenWeatherMap$$ {
    override func spec() {
        context("with good network") {
            var weatherProvider: WeatherProvider!
            beforeEach {
                struct NetworkingStub : Networking {
                    func queryWeather(for locationPredicate: LocationPredicate, completion: @escaping (NetworkingWeatherQueryResult) -> Void) {
                        let response = WeatherResponse(
                            coord: .init(lat: 145.77, lon: -16.92),
                            main: .init(
                                temp: 50
                            ),
                            sys: .init(
                                country: "US",
                                sunrise: 1526302800,
                                sunset: 1526353766
                            ),
                            name: "Cupertino",
                            dt: 1526259360
                        )
                        completion(.init(response))
                    }
                }
                weatherProvider = WeatherProviderImp(networking: NetworkingStub())
            }
            for (locationPredicateContext, locationPredicate) in weatherLocationPredicateSamplesWithContext {
                context("when location is \(locationPredicateContext)") {
                    it("should succeed") {
                        var weatherQueryResult: WeatherQueryResult!
                        weatherProvider.queryWeather(for: locationPredicate, completion: { (result) in
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

class WeatherProviderImp_OpenWeatherMap_WeatherProviderImp_QueryWeather_ET : QuickSpec, WeatherProviderImp_OpenWeatherMap$$ {
    override func spec() {
        context("with bad network") {
            var weatherProvider: WeatherProvider!
            beforeEach {
                enum FakeError : Error {
                    case unknownFailure
                }
                struct NetworkingStub : Networking {
                    func queryWeather(for location: LocationPredicate, completion: @escaping (NetworkingWeatherQueryResult) -> Void) {
                        completion(.failure(.other(FakeError.unknownFailure)))
                    }
                }
                weatherProvider = WeatherProviderImp(networking: NetworkingStub())
            }
            for (locationPredicateContext, locationPredicate) in weatherLocationPredicateSamplesWithContext {
                context("when location is \(locationPredicateContext)") {
                    it("should error") {
                        var weatherQueryResult: WeatherQueryResult!
                        weatherProvider.queryWeather(for: locationPredicate, completion: { (result) in
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
