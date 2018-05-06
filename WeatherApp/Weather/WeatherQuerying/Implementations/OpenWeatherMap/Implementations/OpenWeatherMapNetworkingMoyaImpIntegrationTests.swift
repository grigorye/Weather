//
//  OpenWeatherMapNetworkingMoyaImpTests.swift
//  WeatherApp
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import WeatherApp

import Result

class OpenWeatherMapNetworking_QueryWeather_IT : QuickSpec {
    override func spec() {
        let networking: OpenWeatherMapNetworking! = OpenWeatherMapNetworkingMoyaImp()
        for (locationContext, locationPredicate) in openWeatherMapLocationPredicateSamplesWithContext {
            context("when location is \(locationContext)") {
                it("should succeed unless there's connectivity issue") {
                    var weatherRequestResult: OpenWeatherMapNetworking.WeatherQueryResult!
                    networking.queryWeather(for: locationPredicate, completion: { (result) in
                        weatherRequestResult = result
                    })
                    expect(weatherRequestResult).toEventuallyNot(beNil())
                    switch weatherRequestResult {
                    case .success(let response)?:
                        expect(response.main.temp).to(beGreaterThan(0/*kelvins*/))
                    case .failure(let networkingError)?:
                        if case OpenWeatherMapNetworkingError.httpStatus(let statusCode, _) = networkingError {
                            expect(statusCode) != 404
                        }
                    default:
                        ()
                    }
                }
            }
        }
    }
}

class OpenWeatherMapNetworkingMoyaImp_QueryWeather_MissingIT : QuickSpec {
    override func spec() {
        let networking: OpenWeatherMapNetworking! = OpenWeatherMapNetworkingMoyaImp()
        for (locationContext, locationPredicate) in openWeatherMapMissingLocationPredicateSamplesWithContext {
            context("when location is missing \(locationContext)") {
                it("should result in 404 unless there's connectivity issue") {
                    var weatherRequestResult: OpenWeatherMapNetworking.WeatherQueryResult!
                    networking.queryWeather(for: locationPredicate, completion: { (result) in
                        weatherRequestResult = result
                    })
                    expect(weatherRequestResult).toEventuallyNot(beNil())
                    switch weatherRequestResult {
                    case .success(let response)?:
                        fail("\(response)")
                    case .failure(let error)?:
                        if case OpenWeatherMapNetworkingError.httpStatus(let statusCode, _) = error {
                            expect(statusCode) == 404
                        }
                    default:
                        ()
                    }
                }
            }
        }
    }
}
