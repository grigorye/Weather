//
//  MoyaNetworkingTests.swift
//  OpenWeatherMapKit/NetworkingImp/Moya
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import OpenWeatherMapKit
import Quick
import Nimble
import Moya

class NetworkingImp_Moya_MoyaNetworking_QueryWeather_T : QuickSpec, NetworkingImp_Moya$$ {
    override func spec() {
        context("with good network") {
            var networking: Networking!
            beforeEach {
                let moyaProvider = MoyaNetworking.MoyaProvider(stubClosure: MoyaProvider.immediatelyStub)
                networking = MoyaNetworking(moyaProvider: moyaProvider)
            }
            for (locationContext, locationPredicate) in locationPredicateSamplesWithContext {
                context("when location is \(locationContext)") {
                    it("should succeed") {
                        var weatherRequestResult: WeatherQueryResult!
                        networking.queryWeather(for: locationPredicate, completion: { (result) in
                            weatherRequestResult = result
                        })
                        expect(weatherRequestResult).notTo(beNil())
                        var response: WeatherResponse!
                        expect { response = try weatherRequestResult.dematerialize() }.notTo(throwError())
                        expect(response.main.temp).to(beGreaterThan(0/*kelvins*/))
                    }
                }
            }
        }
    }
}

class NetworkingImp_Moya_MoyaNetworking_QueryWeather_ET : QuickSpec, NetworkingImp_Moya$$ {
    override func spec() {
        context("with bad network") {
            let sampleResponseClosuresWithFailureContext: [(String, Endpoint.SampleResponseClosure)] = [
                ("http 404", { .networkResponse(404, Data()) }),
                ("user cancelled", { .networkError(NSError(domain: NSCocoaErrorDomain, code: NSUserCancelledError)) }),
                ("timed out", { .networkError(NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut)) })
            ]
            for (failureContext, sampleResponseClosure) in sampleResponseClosuresWithFailureContext {
                context("due \(failureContext)") {
                    var networking: Networking!
                    beforeEach {
                        let endpointClosure = { (target: MoyaTarget) -> Endpoint in
                            let url = URL(target: target).absoluteString
                            return Endpoint(url: url, sampleResponseClosure: sampleResponseClosure, method: target.method, task: target.task, httpHeaderFields: target.headers)
                        }
                        let moyaProvider = MoyaNetworking.MoyaProvider(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
                        networking = MoyaNetworking(moyaProvider: moyaProvider)
                    }
                    for (locationContext, locationPredicate) in locationPredicateSamplesWithContext {
                        context("when location is \(locationContext)") {
                            it("should error") {
                                var weatherQueryResult: WeatherQueryResult!
                                networking.queryWeather(for: locationPredicate, completion: { (result) in
                                    weatherQueryResult = result
                                })
                                expect(weatherQueryResult).notTo(beNil())
                                expect { try weatherQueryResult.dematerialize() }.to(throwError())
                            }
                        }
                    }
                }
            }
        }
    }
}
