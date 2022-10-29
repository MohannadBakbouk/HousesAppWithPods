//
//  HouseDetailsViewModelTests.swift
//  HousesAppTests
//
//  Created by Mohannad on 10/26/22.
//
import XCTest
import Combine
@testable import HousesApp

class HouseDetailsViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    var viewModel: HouseDetailsViewModelProtocol!
    
    override func setUpWithError() throws {
        viewModel = HouseDetailsViewModel(info: MockHouseService.fetchFormatedHouse(), photoService: MockPhotoService(), actorService: MockActorService())
        cancellables = []
    }

    override func tearDownWithError() throws {
        viewModel = nil
        cancellables = []
    }

    func testAreHouseDetailsPublished() throws {
        let expectation = expectation(description: "Testing the house's details are published to view ")
        var received: HouseViewData!
        viewModel.details.sink { completed in
            expectation.fulfill()
        } receiveValue: { value in
            received = value
        }.store(in: &cancellables)

        _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssert(received.name == MockHouseService.fetchFormatedHouse().name , "Failed to publish the house's details ")
    }
    
    func testIsGalleryPublished() throws {
        let expectation = expectation(description: "Fetching the house's gallery from api")
        var results : [PhotoViewData] = []
        
        viewModel.gallery.sink { completed in
            expectation.fulfill()
        } receiveValue: { value in
            results.append(contentsOf: value)
        }.store(in: &cancellables)
        viewModel.loadHousePhotos()
        
        _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssert(results.count > 0 , "Failed to fetch the house's gallery")
    }
    
    func testAreActorsPublished() throws {
        let expectation = expectation(description: "Fetching the actors from api")
        var results : [ActorViewData] = []
        
        viewModel.actors.sink { completed in
            expectation.fulfill()
        } receiveValue: { value in
            results.append(contentsOf: value ?? [])
        }.store(in: &cancellables)
        viewModel.loadActors()
        
        _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssert(results.count > 0 , "Failed to fetch actors")
    }
    
    func testIsErrorPublished() throws {
        let expectation = expectation(description: "Testing the error is published ")
        let error = PassthroughSubject<ErrorDataView? , Never>()
        var received: String?
        
        error.assign(to: \.value , on : viewModel.error)
        .store(in: &cancellables)
        
        viewModel.error.sink { completed in
            expectation.fulfill()
        } receiveValue: { value in
            received = value?.message
        }.store(in: &cancellables)
        
        error.send(ErrorDataView(with: .errorOccured))
        
        _ = XCTWaiter.wait(for: [expectation], timeout: 5)
         XCTAssert( received == APIError.errorOccured.message ,  "Failed to publish error message")
    }

}
