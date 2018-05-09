//
//  CityListJsonDecoding.swift
//  OpenWeatherMapKit
//
//  Created by Grigory Entin on 08/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation

public func decodeCityListJson() throws -> [CityInfo] {
    let bundle: Bundle = .current
    let pathToGZ = bundle.url(forResource: "city.list.json", withExtension: "gz")!
    let dataGZ = try Data(contentsOf: pathToGZ)
    let data = (dataGZ as NSData).gunzipped()!
    let decoded = try JSONDecoder().decode([CityInfo].self, from: data)
    return decoded
}
