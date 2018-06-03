//
//  XCUIApplication+CleanLaunching.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 03/06/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import XCTest

private var scheduledForCleanup = [() -> Void]()

func deferTilCleanup(_ block: @escaping () -> Void) {
    
    scheduledForCleanup.append(block)
}

extension XCUIApplication {
    
    func prepareForLaunchingWithClearData() {
        
        precondition(scheduledForCleanup.count == 0)

        let fileManager = FileManager.default
        let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let homeURL = try! fileManager.createTemplateDirectory(at: temporaryDirectoryURL, prefix: "Container-")
        try! fileManager.createDirectory(at: homeURL, withIntermediateDirectories: true, attributes: nil)
        deferTilCleanup {
            try! fileManager.removeItem(at: homeURL)
        }
        assert(try! homeURL.checkResourceIsReachable())
        
        launchEnvironment["HOME"] = homeURL.path
        launchEnvironment["CFFIXED_USER_HOME"] = homeURL.path
    }
    
    func prepareForTerminationWithClearData() {
        
        precondition(scheduledForCleanup.count > 0)
        
        scheduledForCleanup.forEach { $0() }
        scheduledForCleanup = []
    }
}
