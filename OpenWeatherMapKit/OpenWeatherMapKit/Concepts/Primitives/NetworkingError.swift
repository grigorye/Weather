//
//  NetworkingError.swift
//  OpenWeatherMapKit
//
//  Created by Grigory Entin on 06/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation.NSURLResponse

/// Wrapper for implementation specific errors, existing mainly to expose HTTP status errors.
public enum NetworkingError : Swift.Error {
    case httpStatus(statusCode: Int, response: URLResponse?)
    case other(Error)
}
