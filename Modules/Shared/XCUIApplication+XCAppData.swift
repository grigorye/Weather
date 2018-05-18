//
//  XCUIApplication+XCAppData.swift
//  WeatherApp
//
//  Created by Grigory Entin on 18/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import XCTest
import Foundation

extension XCUIApplication {

    /// Adjust the reciever so that it uses the given .xcappdata from the current bundle.
    func prepareForLaunchWithBundledXCAppData(withName xcAppDataName: String) {
        
        let fileManager = FileManager.default
        let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let bundle = Bundle.current
        let bundledXCAppDataURL = bundle.url(forResource: xcAppDataName, withExtension: "xcappdata")!
        let xcAppDataURL = temporaryDirectoryURL.appendingPathComponent(bundledXCAppDataURL.lastPathComponent)
        try? fileManager.removeItem(at: xcAppDataURL)
        try! fileManager.copyItem(at: bundledXCAppDataURL, to: xcAppDataURL)

        prepareForLaunchWithXCAppData(installedAt: xcAppDataURL)
    }
    
    func prepareForCleanLaunch() {
        
        let fileManager = FileManager.default
        let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let xcAppDataURL = temporaryDirectoryURL.appendingPathComponent("Clean.xcappdata")
        try? fileManager.removeItem(at: xcAppDataURL)
        try! fileManager.createDirectory(at: xcAppDataURL, withIntermediateDirectories: false)
        
        prepareForLaunchWithXCAppData(installedAt: xcAppDataURL)
    }
    
    func prepareForLaunchWithXCAppData(installedAt xcAppDataURL: URL) {
        let homeURL = xcAppDataURL.appendingPathComponent("AppData")
        self.launchEnvironment["HOME"] = homeURL.path
        self.launchEnvironment["CFFIXED_USER_HOME"] = homeURL.path
    }
}
