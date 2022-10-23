//
//  HouseService.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Combine

protocol HouseServiceProtocol {
    func fetchHouses() -> AnyPublisher<[HouseQueryItem] , APIError>
}

final class HouseService: HouseServiceProtocol {
    let apiManager : APIManagerProtocol
    
    init(apiManager : APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func fetchHouses() -> AnyPublisher<[HouseQueryItem] , APIError>{
        return apiManager.request(endpoint: .houses, method: .Get, params: nil)
    }
}

