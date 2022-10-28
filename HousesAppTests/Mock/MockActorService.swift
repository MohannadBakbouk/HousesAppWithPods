//
//  MockActorService.swift
//  HousesAppTests
//
//  Created by Mohannad on 10/26/22.
//
import Foundation
import Combine
@testable import HousesApp

final class MockActorService : ActorServiceProtocol{
    func fetchActorDetails(_ id: Int) -> AnyPublisher<ActorQueryItem, APIError> {
        let fileName = "Actor\(id)Response"
        let data = try? Data(contentsOf: Bundle.main.url(forResource: fileName, withExtension: "json")!)
        let response = try! JSONDecoder().decode(ActorQueryItem.self, from: data!)
        let stream : AnyPublisher<ActorQueryItem, APIError> = Result.Publisher(response).eraseToAnyPublisher()
        return stream
    }
}
