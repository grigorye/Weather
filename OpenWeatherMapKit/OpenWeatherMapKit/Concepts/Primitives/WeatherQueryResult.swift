//
//  WeatherQueryResult.swift
//  OpenWeatherMapKit
//
//  Created by Grigory Entin on 06/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Result

public typealias WeatherQueryResult = Result<WeatherResponse, NetworkingError>
