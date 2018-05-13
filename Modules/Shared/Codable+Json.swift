//
//  Codable+Json.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation

extension Decodable {
    
    init(fromJson string: String) throws {
        self = try JSONDecoder().decode(Self.self, from: string.data(using: .utf8)!)
    }
}

extension Encodable {
    
    func asJson() -> String {
        return String(data: try! JSONEncoder().encode(self), encoding: .utf8)!
    }
}
