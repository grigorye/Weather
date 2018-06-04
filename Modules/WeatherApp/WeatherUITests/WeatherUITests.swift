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
let tables = app.tables
let navigationBars = app.navigationBars

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

    lazy var iterationsCount = min(cityNames.count/*50*/, 3)
    
    func testRepeatedNavigation() {
        
        for cityName in cityNames[0..<iterationsCount] {
            mainStaticText.tap()
            addCityButton.tap()
            searchField.typeText(cityName)
            cancelButton.tap()
            debugButton.tap()
        }
    }
    
    func testRepeatedAddCityAndOpenDetails() {
        
        mainStaticText.tap()
        for cityName in cityNames[0..<iterationsCount] {
            addCityButton.tap()
            searchField.typeText(cityName)
            tableViews.children(matching: .cell).element(boundBy: 0).tap()
            tableViews.cells.staticTexts[cityName].tap()
            navigationBars[cityName].buttons["Back"].tap()
        }
        debugButton.tap()
    }
    
    func testRepeatedAddCurrentLocation() {
        
        mainStaticText.tap()
        for _ in (0..<iterationsCount) {
            addCityButton.tap()
            addUIInterruptionMonitor(withDescription: "Location Permissions") { (alert) in
                alert.buttons["Allow"].tap()
                return true
            }
            tables/*@START_MENU_TOKEN@*/.cells.staticTexts["Always goes with you"]/*[[".cells.staticTexts[\"Always goes with you\"]",".staticTexts[\"Always goes with you\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        }
        debugButton.tap()
    }
    
    func testRepeatedAddCustomLocation() {
        mainStaticText.tap()
        for _ in (0..<iterationsCount) {
            addCityButton.tap()
            tables.cells.staticTexts["When in doubt"].tap()
            let netherlandsMap = app.maps.firstMatch
            netherlandsMap.swipeRight()
            app.navigationBars["WeatherAppKit.CitySelectionOnMapView"].buttons["Done"].tap()
        }
        debugButton.tap()
    }
}
