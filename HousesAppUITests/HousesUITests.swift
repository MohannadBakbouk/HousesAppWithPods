//
//  HousesAppUITests.swift
//  HousesAppUITests
//
//  Created by Mohannad on 10/23/22.
//
import XCTest
import Swifter
@testable import HousesApp

private let collectionViewIdentifier = "HouseCollectionView"

class HousesUITests: SuperXCTestCase {
   
    override func setUpWithError() throws {
        app.launchArguments = ["-uitesting"]
    }

    override func tearDownWithError() throws {
        server.stop()
        app.terminate()
    }
    
    func testIsNavigationBarHidden(){
        initNormalServer()
        app.launch()
        XCTAssert(app.navigationBars.count == 0)
    }

    func testAreHousesShown() throws {
        initNormalServer()
        app.launch()
        XCTAssert(app.collectionViews[collectionViewIdentifier].waitForExistence(timeout: 5))
        XCTAssert(app.collectionViews[collectionViewIdentifier].cells.count > 0)
    }
    
    func testAreHouseInformationShown(){
        initNormalServer()
        app.launch()
        XCTContext.runActivity(named: "House information are displayed") { _ in
            XCTAssert(app.collectionViews[collectionViewIdentifier].waitForExistence(timeout: 5))
            XCTAssert(app.images["houseImageView"].exists)
            XCTAssert(app.images["addressImageView"].exists)
            XCTAssert(app.staticTexts["House Arryn of the Eyrie"].exists)
            XCTAssert(app.staticTexts["The Vale"].exists)
        }
    }
    
    func testSelectingHouseShowsDetails(){
        initNormalServer()
        app.launch()
        XCTAssert(app.collectionViews[collectionViewIdentifier].waitForExistence(timeout: 5))
        app.collectionViews[collectionViewIdentifier].cells.firstMatch.tap()
        XCTAssert(app.navigationBars["Details"].exists)
    }
    
    func testIsErrorShown(){
        initFailureServer()
        app.launch()
        XCTAssert(app.collectionViews[collectionViewIdentifier].waitForExistence(timeout: 5))
        XCTAssert(app.collectionViews[collectionViewIdentifier].staticTexts["an internal error occured in server side please try again later"].exists)
    }
}
