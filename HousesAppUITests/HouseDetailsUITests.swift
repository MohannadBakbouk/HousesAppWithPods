//
//  HouseDetailsUITests.swift
//  HousesAppUITests
//
//  Created by Mohannad on 10/28/22.
//
import XCTest
@testable import HousesApp

private let collectionViewIdentifier = "HouseCollectionView"
private let titlesTableView = "TitlesTableView"
private let targetCellIdentifier = "HouseCell_8"
private let galleryCollection = "GalleryCollection"
private let actorsCollection = "actorsCollection"

class HouseDetailsUITests: SuperXCTestCase {

    override func setUpWithError() throws {
        app.launchArguments = ["-uitesting"]
    }

    override func tearDownWithError() throws {
        server.stop()
        app.terminate()
    }

    func testIsNavigationBarShown() throws {
        navigateToDetails()
        XCTAssert(app.navigationBars["Details"].exists)
    }
    
    func testIsGalleryShown(){
        navigateToDetails()
        XCTAssert(app.collectionViews[galleryCollection].waitForExistence(timeout: 10))
        XCTAssert(app.collectionViews[galleryCollection].cells.count > 0)
        XCTAssert(app.collectionViews[galleryCollection].cells.firstMatch.isSelected)
    }
    
    func testIsMainPhotoShown(){
        navigateToDetails()
        XCTAssert(app.images["SelectedGalleryPicture"].exists)
        XCTAssert(app.collectionViews[galleryCollection].cells.firstMatch.isSelected)
    }
    
    func testAreActorsShown(){
        navigateToDetails()
        XCTAssert(app.collectionViews[actorsCollection].waitForExistence(timeout: 10))
        XCTAssert(app.collectionViews[actorsCollection].cells.count > 0)
    }
    
    func testAreActorsNamesShown(){
        navigateToDetails()
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for collectionView to appear")], timeout: 20)
        XCTAssert(app.collectionViews[actorsCollection].exists)
        XCTAssert(app.collectionViews[actorsCollection].cells.staticTexts["Robb Stark"].exists)
        XCTAssert(app.collectionViews[actorsCollection].cells.staticTexts["Robin"].exists)
        app.collectionViews[actorsCollection].swipeLeft()
        XCTAssert(app.collectionViews[actorsCollection].cells.staticTexts["Robin Flint"].exists)
    }
    
    func testAreTitlesShown(){
        navigateToDetails()
        XCTAssert(app.tables[titlesTableView].waitForExistence(timeout: 15))
        XCTAssert(app.tables[titlesTableView].cells.count > 0)
    }
    
    func testIsArmyValueShown(){
        navigateToDetails()
        XCTAssert(app.staticTexts["Tenny, a sun in splendour beneath a chevron inverted argent"].exists)
    }
    
    func testIsBackButtonWorking(){
        navigateToDetails()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssert(app.collectionViews[collectionViewIdentifier].waitForExistence(timeout: 15))
        XCTAssert(app.collectionViews[collectionViewIdentifier].cells.count > 0)
    }
    
    func navigateToDetails(){
        initNormalServer()
        app.launch()
        _ = app.collectionViews[collectionViewIdentifier].waitForExistence(timeout: 30)
        _ = app.collectionViews[collectionViewIdentifier].cells[targetCellIdentifier].waitForExistence(timeout: 20)
        app.collectionViews[collectionViewIdentifier].cells[targetCellIdentifier].tap()
        
    }
}
