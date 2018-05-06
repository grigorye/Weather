//
//  MoyaResponse+NetworkingError.swift
//  OpenWeatherMapKit
//
//  Created by Grigory Entin on 06/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Moya

/// Adjustsments for NetworkingError.
extension Moya.Response {
    
    public func filter(statusCodes: ClosedRange<Int>) throws -> Response {
        guard statusCodes.contains(statusCode) else {
            throw NetworkingError.httpStatus(statusCode: statusCode, response: response)
        }
        return self
    }
    
    public func filter(statusCode: Int) throws -> Response {
        return try filter(statusCodes: statusCode...statusCode)
    }
}
