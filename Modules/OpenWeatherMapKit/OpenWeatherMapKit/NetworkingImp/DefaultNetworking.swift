//
//  DefaultNetworking.swift
//  OpenWeatherMapKit
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

public func defaultNetworking() -> Networking {
    return NetworkingImp$.container.resolve(Networking.self)!
}
