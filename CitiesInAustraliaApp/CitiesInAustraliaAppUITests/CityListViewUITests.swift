//
//  CityListViewUITests.swift
//  CitiesInAustraliaAppUITests
//
//  Created by Harshita Gali on 13/09/2025.
//

import XCTest
@testable import CitiesInAustraliaApp

final class CityListViewUITests: XCTestCase {

    
    var app : XCUIApplication!
    
    override func setUp(){
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown(){
        app = nil
    }
    
    func testIsNavTitleVisble(){
        let navBar = app.navigationBars["Cities of Australia"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 2),"Navigation title not visible")
    }
    
    func testExpandAndCollapseState(){
        
        let stateName  = app.staticTexts["state_New South Wales"]
        XCTAssertTrue(stateName.waitForExistence(timeout: 2))
        
        let chevronSymbol = app.buttons["chevron_New South Wales"]
        XCTAssertTrue(chevronSymbol.exists)
        chevronSymbol.tap()
        
        let cityName = app.staticTexts["Sydney"]
        XCTAssertTrue(cityName.waitForExistence(timeout: 2),"Cities not found")
        
        chevronSymbol.tap()
            XCTAssertFalse(cityName.exists, "City did not collapse")
    }

    
}
