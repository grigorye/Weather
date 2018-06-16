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
let tableFirstCell = app.tables.children(matching: .cell).element(boundBy: 0)
let tableCells = app.tables.cells
let map = app.maps.firstMatch
let table = app.tables.firstMatch
let navigationBars = app.navigationBars

func tableCellStaticText(_ identifier: String) -> XCUIElement {
    return tableCells.staticTexts.existingMatch(identifier)
}

extension XCUIElementQuery {
    
    func existingMatch(_ identifier: String) -> XCUIElement {
        return self.matching(identifier: identifier).lastExistingElement
    }

    var lastExistingElement: XCUIElement {
        for i in (0..<self.count).reversed() {
            let element = self.element(boundBy: i)
            if element.exists {
                return element
            }
        }
        fatalError()
    }
    
}

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
            tableFirstCell.tap()
            tableCellStaticText(cityName).tap()
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
            tableCellStaticText("Always goes with you").tap()
            table.swipeDown()
        }
        debugButton.tap()
    }
    
    func testRepeatedAddCustomLocation() {
        
        mainStaticText.tap()
        for _ in (0..<iterationsCount) {
            addCityButton.tap()
            tableCellStaticText("When in doubt").tap()
            map.swipeRight()
            navigationBars["WeatherAppKit.CitySelectionOnMapView"].buttons["Done"].tap()
        }
        debugButton.tap()
    }
}
