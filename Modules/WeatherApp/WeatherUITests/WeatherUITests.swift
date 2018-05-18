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
        
        app.prepareForCleanLaunch()
        app.launch()
    }
    
    func test() {
        
        let tablesQuery = app.tables
        let cancelButton = app.buttons["Cancel"]
        let addCityButton = tablesQuery.buttons["Add City"]
        
        addCityButton.tap()
        cancelButton.tap()
        
        addCityButton.tap()
        let citySearchField = app.searchFields["City"]
        citySearchField.tap()
        
        citySearchField.buttons["Bookmarks"].tap()
        app.searchFields["Postcode"].buttons["Bookmarks"].tap()
        
        cancelButton.tap()
        
        addCityButton.tap()
        citySearchField.tap()

        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Always goes with you"]/*[[".cells.staticTexts[\"Always goes with you\"]",".staticTexts[\"Always goes with you\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        addCityButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Current Location"]/*[[".cells.staticTexts[\"Current Location\"]",".staticTexts[\"Current Location\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
