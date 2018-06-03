//
//  WeatherUITests.swift
//  WeatherUITests
//
//  Created by Grigory Entin on 03/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import XCTest

let app = XCUIApplication()

class WeatherUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app.launchArguments = [
            "-forceDebugScene", "YES"
        ]
        app.launchEnvironment = [
            "MallocStackLogging":"1"
        ]
        app.launch()
    }
    
    func testRepeatedNavigation() {
        
        let app = XCUIApplication()
        
        let debugButton = app.navigationBars["WeatherAppKit.UserCitiesView"].buttons["Debug"]
        let mainStaticText = app.tables.staticTexts["Main"]
        let addCityButton = app.tables.buttons["Add City"]
        let cancelButton = app.buttons["Cancel"]
        let searchField = app.searchFields["City"]
        
        let cityNames: [String] = {
            let jsonURL = Bundle.current.url(forResource: "CityNamesSample", withExtension: "json")!
            let jsonData = try! Data(contentsOf: jsonURL)
            return try! JSONDecoder().decode([String].self, from: jsonData)
        }()
        
        for cityName in cityNames {
            mainStaticText.tap()
            addCityButton.tap()
            searchField.typeText(cityName)
            cancelButton.tap()
            debugButton.tap()
        }
    }
}
