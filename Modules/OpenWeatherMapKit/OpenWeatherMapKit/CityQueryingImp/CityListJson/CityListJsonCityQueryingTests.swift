//
//  CityListJsonCityQueryingTests.swift
//  OpenWeatherMapKit/CityQueryingImp/CityListJson
//
//  Created by Grigory Entin on 04/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import OpenWeatherMapKit
import Quick
import Nimble

class CityQueryingImp_CityListJson_CityListJsonCityQuerying_queryCity_T : QuickSpec, CityQueryingImp_CityListJson$$ {
    override func spec() {
        let cityQuerying: CityQuerying = CityListJsonCityQuerying()
        it("should return after delay first time") {
            var cityQueryResult: CityQueryResult!
            let query = cityQuerying.queryCity(matching: "London", completion: { (result) in
                cityQueryResult = result
            })
            expect(query).toNot(beNil())
            expect(cityQueryResult).toEventuallyNot(beNil(), timeout: 30)
        }
        it("should return search result much faster 2nd time") {
            var cityQueryResult: CityQueryResult!
            let query = cityQuerying.queryCity(matching: "London", completion: { (result) in
                cityQueryResult = result
            })
            expect(query).toNot(beNil())
            expect(cityQueryResult).toEventuallyNot(beNil())
        }
    }
}
