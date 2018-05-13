//
//  NetworkingImpTests.swift
//  WeatherApp/OpenWeatherMap/NetworkingImp
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import WeatherApp

import Result

class OpenWeatherMap_NetworkingImp_QueryWeather_IT : QuickSpec, OpenWeatherMap_NetworkingImp$$ {
    override func spec() {
        let networking = container.resolve(Networking.self)!
        for (locationContext, locationPredicate) in locationPredicateSamplesWithContext {
            context("when location is \(locationContext)") {
                it("should succeed unless there's connectivity issue") {
                    var weatherRequestResult: WeatherQueryResult!
                    networking.queryWeather(for: locationPredicate, completion: { (result) in
                        weatherRequestResult = result
                    })
                    expect(weatherRequestResult).toEventuallyNot(beNil())
                    switch weatherRequestResult {
                    case .success(let response)?:
                        expect(response.main.temp).to(beGreaterThan(0/*kelvins*/))
                    case .failure(let networkingError)?:
                        if case NetworkingError.httpStatus(let statusCode, _) = networkingError {
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

class OpenWeatherMap_NetworkingImp_QueryWeather_MissingIT : QuickSpec, OpenWeatherMap_NetworkingImp$$ {
    override func spec() {
        let networking = container.resolve(Networking.self)!
        for (locationContext, locationPredicate) in missingLocationPredicateSamplesWithContext {
            context("when location is missing \(locationContext)") {
                it("should result in 404 unless there's connectivity issue") {
                    var weatherRequestResult: WeatherQueryResult!
                    networking.queryWeather(for: locationPredicate, completion: { (result) in
                        weatherRequestResult = result
                    })
                    expect(weatherRequestResult).toEventuallyNot(beNil())
                    switch weatherRequestResult {
                    case .success(let response)?:
                        fail("\(response)")
                    case .failure(let error)?:
                        if case NetworkingError.httpStatus(let statusCode, _) = error {
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
