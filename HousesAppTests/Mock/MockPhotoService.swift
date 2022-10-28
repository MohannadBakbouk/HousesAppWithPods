//
//  MockPhotoService.swift
//  HousesAppTests
//
//  Created by Mohannad on 10/26/22.
//
import Foundation
import Combine
@testable import HousesApp

final class MockPhotoService : PhotoServiceProtocol{
    func searchPhotos(_ params: PhotoParams) -> AnyPublisher<PhotoQuery, APIError> {
        let fileName = "\(params.query)PhotosResponse"
        let data = try? Data(contentsOf: Bundle.main.url(forResource: fileName, withExtension: "json")!)
        let response = try! JSONDecoder().decode(PhotoQuery.self, from: data!)
        let stream : AnyPublisher<PhotoQuery, APIError> = Result.Publisher(response).eraseToAnyPublisher()
        return stream
    }
}
