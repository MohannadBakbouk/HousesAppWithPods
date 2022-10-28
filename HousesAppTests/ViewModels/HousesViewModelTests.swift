//
//  HousesViewModelTests.swift
//  HousesAppTests
//
//  Created by Mohannad on 10/26/22.
//
import XCTest
import Combine
@testable import HousesApp

class HousesViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    var viewModel: HousesViewModelProtocol!
    
    override func setUpWithError() throws {
        viewModel = HousesViewModel(houseService: MockHouseService(), photoService: MockPhotoService())
        cancellables = []
    }

    override func tearDownWithError() throws {
        viewModel = nil
        cancellables = []
    }

    func testAreHousesPublished() throws {
        let expectation = expectation(description: "Testing the feteched houses are published to view ")
        var results : [HouseViewData] = []
        viewModel.houses.sink { completed in
            expectation.fulfill()
        } receiveValue: { items in
            results.append(contentsOf: items)
        }.store(in: &cancellables)
        viewModel.loadHouses()
        _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssert(results.count == 10 , "Failed to publish the fetched houses")
    }
    
    func testIsLoadingSignalPublished() throws {
        let expectation = expectation(description: "Testing the isLoading signal of load Houses")
        var received : [Bool] = [] , expected = [true , false]
        viewModel.isLoading.sink { completed in
            expectation.fulfill()
        } receiveValue: { value in
            received.append(value)
        }.store(in: &cancellables)
        
        viewModel.loadHouses()
        
        _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssert(received == expected, "Failed to publish isLoading signal")
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
        
        error.send(ErrorDataView(with: .internetOffline))
        
        _ = XCTWaiter.wait(for: [expectation], timeout: 5)
         XCTAssert( received == APIError.internetOffline.message ,  "Failed to publish error message")
    }
}
