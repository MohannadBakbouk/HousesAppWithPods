//
//  ActorService.swift
//  HousesApp
//
//  Created by Mohannad on 10/24/22.
//
import Combine

protocol ActorServiceProtocol {
    func fetchActorDetails(_ id : Int) -> AnyPublisher<ActorQueryItem , APIError>
}

final class ActorService: ActorServiceProtocol {
    let apiManager : APIManagerProtocol
    
    init(apiManager : APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func fetchActorDetails(_ id : Int) -> AnyPublisher<ActorQueryItem , APIError>{
        return apiManager.request(endpoint: .actor(id: id), method: .Get, params: nil)
    }
}
