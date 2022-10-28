//
//  HousesAppTests.swift
//  HousesAppTests
//
//  Created by Mohannad on 10/23/22.
//
import XCTest
import Combine
@testable import HousesApp

class MockServicesTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    var houseService: HouseServiceProtocol!
    var photoService: PhotoServiceProtocol!
    var actorService: ActorServiceProtocol!
    
    override func setUpWithError() throws {
        houseService = MockHouseService()
        photoService = MockPhotoService()
        actorService = MockActorService()
        cancellables = []
    }

    override func tearDownWithError() throws {
        houseService = nil
        photoService = nil
        actorService = nil
        cancellables = []
    }
  
    func testMockedHouseService() throws {
        let expectation = expectation(description: "feteching houses from api")
        var results : [HouseQueryItem] = []
       
        houseService.fetchHouses()
        .sink {completed in
            expectation.fulfill()
        } receiveValue: { value in
            results.append(contentsOf: value)
        }.store(in: &cancellables)
        _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        XCTAssert(results.count > 0  , "Failed to fetch house from api")
    }
    
    func testMockedPhotoService() throws {
        let expectation = expectation(description: "feteching houses from api")
        var results : [PhotoQueryItem] = []
        
        photoService.searchPhotos(PhotoParams())
        .sink {completed in
            expectation.fulfill()
        } receiveValue: { value in
            results.append(contentsOf: value.results)
        }.store(in: &cancellables)
        _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        XCTAssert(results.count > 0  , "Failed to fetch photos from api")
    }
    
    func testMockedActorService() throws {
        let expectation = expectation(description: "fetching actor's details from api")
        var result: ActorQueryItem?
        
        actorService.fetchActorDetails(1880)
        .sink { completed in
            expectation.fulfill()
        } receiveValue: { value in
            result = value
        }.store(in: &cancellables)

        _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssert(result != nil   , "Failed to fetch actor's details from api")
    }

}
