//
//  WeatherProviderImpTests.swift
//  WeatherApp/OpenWeatherMap
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import WeatherApp
import OpenWeatherMapKit
import Result

class WeatherProviderImp_OpenWeatherMap_WeatherProviderImp_QueryWeather_T : QuickSpec, WeatherProviderImp_OpenWeatherMap$$ {
    override func spec() {
        context("with good network") {
            var WeatherProvider: WeatherProvider!
            beforeEach {
                struct NetworkingStub : Networking {
                    func queryWeather(for locationPredicate: LocationPredicate, completion: @escaping (WeatherQueryResult) -> Void) {
                        let response = WeatherResponse(main: .init(temp: 50))
                        completion(.init(response))
                    }
                }
                WeatherProvider = WeatherProviderImp(networking: NetworkingStub())
            }
            for (locationPredicateContext, locationPredicate) in weatherLocationPredicateSamplesWithContext {
                context("when location is \(locationPredicateContext)") {
                    it("should succeed") {
                        var weatherQueryResult: WeatherProvider.WeatherQueryResult!
                        WeatherProvider.queryWeather(for: locationPredicate, completion: { (result) in
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
            var WeatherProvider: WeatherProvider!
            beforeEach {
                enum FakeError : Error {
                    case unknownFailure
                }
                struct NetworkingStub : Networking {
                    func queryWeather(for location: LocationPredicate, completion: @escaping (WeatherQueryResult) -> Void) {
                        completion(.failure(.other(FakeError.unknownFailure)))
                    }
                }
                WeatherProvider = WeatherProviderImp(networking: NetworkingStub())
            }
            for (locationPredicateContext, locationPredicate) in weatherLocationPredicateSamplesWithContext {
                context("when location is \(locationPredicateContext)") {
                    it("should error") {
                        var weatherQueryResult: WeatherProvider.WeatherQueryResult!
                        WeatherProvider.queryWeather(for: locationPredicate, completion: { (result) in
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
