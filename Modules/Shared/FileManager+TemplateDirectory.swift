//
//  FileManager+TemporaryDirectories.swift
//  WeatherAppUITests
//
//  Created by Grigory Entin on 03/06/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation

extension FileManager {
    
    func createTemplateDirectory(at url: URL, prefix: String) throws -> URL {
        
        // Whole thing should be replaced with `mkdtemp`.
        
        let timestamp: String = {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            return dateFormatter.string(from: date)
        }()
        let directoryName = "\(prefix)\(timestamp)"
        let directoryURL = url.appendingPathComponent(directoryName)
        try createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
        return directoryURL
    }
}
