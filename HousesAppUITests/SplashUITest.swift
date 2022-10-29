//
//  SplashUITest.swift
//  HousesAppUITests
//
//  Created by Mohannad on 10/29/22.
//
import XCTest

class SplashUITest: XCTestCase {
    var app = XCUIApplication()
    override func setUpWithError() throws {
        app.launchArguments = ["-uitesting"]
    }

    override func tearDownWithError() throws {
        app.terminate()
    }
    
    func testIsSlugNameShown(){
        app.launch()
        XCTAssert(app.staticTexts["SlugLabel"].exists)
    }
    
    func testIsIndicatorShown(){
        app.launch()
        XCTAssert(app.activityIndicators["InidicatorView"].exists)
    }
}
