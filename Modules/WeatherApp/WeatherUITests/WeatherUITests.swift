//
//  WeatherUITests.swift
//  WeatherUITests
//
//  Created by Grigory Entin on 03/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import XCTest

let app = XCUIApplication()
let debugButton = app.navigationBars["WeatherAppKit.UserCitiesView"].buttons["Debug"]
let mainStaticText = app.tables.staticTexts["Main"]
let addCityButton = app.tables.buttons["Add City"]
let cancelButton = app.buttons["Cancel"]
let searchField = app.searchFields.firstMatch
let tableViews = app.tables

class WeatherUITests : XCTestCase {
        
    override func setUp() {
        
        super.setUp()
        
        continueAfterFailure = false
        app.launchArguments = [
            "-forceDebugScene", "YES"
        ]
        app.launchEnvironment = [
            "MallocStackLogging":"1"
        ]
        app.prepareForLaunchingWithClearData()
        app.launch()
    }
    
    override func tearDown() {
        
        app.prepareForTerminationWithClearData()
        
        super.tearDown()
    }
    
    lazy var cityNames: [String] = {
        let jsonURL = Bundle.current.url(forResource: "CityNamesSample", withExtension: "json")!
        let jsonData = try! Data(contentsOf: jsonURL)
        return try! JSONDecoder().decode([String].self, from: jsonData)
    }()

    lazy var iterationsCount = min(cityNames.count, 3)
    
    func testRepeatedNavigation() {
        
        for cityName in cityNames[0..<iterationsCount] {
            mainStaticText.tap()
            addCityButton.tap()
            searchField.typeText(cityName)
            cancelButton.tap()
            debugButton.tap()
        }
    }
    
    func testRepeatedAddCity() {
        
        mainStaticText.tap()
        for cityName in cityNames[0..<iterationsCount] {
            addCityButton.tap()
            searchField.typeText(cityName)
            tableViews.children(matching: .cell).element(boundBy: 0).tap()
        }
        debugButton.tap()
    }
}
