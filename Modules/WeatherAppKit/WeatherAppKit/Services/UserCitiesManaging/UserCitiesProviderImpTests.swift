//
//  UserCitiesProviderImpTests.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 19/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import WeatherAppKit
import RxSwift
import Result

func defaultUserCitiesTestProvider() -> UserCitiesProvider {
    return coreDataUserCitiesImpTestProvider()
}

class UserCitiesProviderImpTests : QuickSpec {
    
    // swiftlint:disable:next function_body_length
    override func spec() {
        
        context("after city is added") {
            let provider = defaultUserCitiesTestProvider()
            let userCityInfo = userCityInfoSample
            try! provider.addUserCity(with: userCityInfo)
            let disposeBag = DisposeBag()
            it("should be there") {
                var observedUserCityInfos: [UserCityInfo] = []
                provider.observableUserCityInfos.subscribe(onNext: { (userCityInfos) in
                    observedUserCityInfos = userCityInfos
                }).disposed(by: disposeBag)
                expect(observedUserCityInfos).toEventually(equal([userCityInfo]))
            }
            it("should have no weather queries in progress") {
                expect(try! provider.hasWeatherQueryInProgress(for: userCityInfo.location)) == false
            }
            it("should track no weather ever queried") {
                expect(try! provider.weatherIsEverQueried(for: userCityInfo.location)) == false
            }
        }
        
        context("after city is deleted") {
            let provider = defaultUserCitiesTestProvider()
            let userCityInfo = userCityInfoSample
            try! provider.addUserCity(with: userCityInfo)
            let disposeBag = DisposeBag()
            it("should be there") {
                var observedUserCityInfos: [UserCityInfo] = []
                provider.observableUserCityInfos.subscribe(onNext: { (userCityInfos) in
                    observedUserCityInfos = userCityInfos
                }).disposed(by: disposeBag)
                expect(observedUserCityInfos).toEventually(equal([userCityInfo]))
            }
            it("should have no weather queries in progress") {
                expect(try! provider.hasWeatherQueryInProgress(for: userCityInfo.location)) == false
            }
            it("should track no weather ever queried") {
                expect(try! provider.weatherIsEverQueried(for: userCityInfo.location)) == false
            }
        }

        context("after weather query is started") {
            let provider = defaultUserCitiesTestProvider()
            let userCityInfo = userCityInfoSample
            try! provider.addUserCity(with: userCityInfo)
            try! provider.setWeatherQueryInProgress(for: userCityInfo.location)
            it("should have weather query in progress") {
                expect(try! provider.hasWeatherQueryInProgress(for: userCityInfo.location)) == true
            }
            it("should track weather as ever queried") {
                expect(try! provider.weatherIsEverQueried(for: userCityInfo.location)) == true
            }
        }
        
        context("after weather query succeeds") {
            let provider = defaultUserCitiesTestProvider()
            let userCityInfo = userCityInfoSample
            try! provider.addUserCity(with: userCityInfo)
            try! provider.setWeatherQueryInProgress(for: userCityInfo.location)
            try! provider.setWeatherQueryCompleted(for: userCityInfo.location, with: .success(weatherInfoSample))
            
            it("should have no weather query in progress") {
                expect(try! provider.hasWeatherQueryInProgress(for: userCityInfo.location)) == false
            }
            it("should track weather as ever queried") {
                expect(try! provider.weatherIsEverQueried(for: userCityInfo.location)) == true
            }
        }
        
        context("after weather query fails") {
            let provider = defaultUserCitiesTestProvider()
            let userCityInfo = userCityInfoSample
            try! provider.addUserCity(with: userCityInfo)
            try! provider.setWeatherQueryInProgress(for: userCityInfo.location)
            try! provider.setWeatherQueryCompleted(for: userCityInfo.location, with: .failure(AnyError(NSError(domain: NSCocoaErrorDomain, code: NSUserCancelledError))))
            
            it("should have no weather query in progress") {
                expect(try! provider.hasWeatherQueryInProgress(for: userCityInfo.location)) == false
            }
            it("should track weather as ever queried") {
                expect(try! provider.weatherIsEverQueried(for: userCityInfo.location)) == true
            }
        }
    }
}
