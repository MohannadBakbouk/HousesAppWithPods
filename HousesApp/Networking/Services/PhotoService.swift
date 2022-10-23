//
//  PhotoService.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Combine

protocol PhotoServiceProtocol {
    func searchPhotos(_ params : PhotoParams) -> AnyPublisher<PhotoQuery , APIError>
}

final class PhotoService: PhotoServiceProtocol {
    let apiManager : APIManagerProtocol
    
    init(apiManager : APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func searchPhotos(_ params : PhotoParams) -> AnyPublisher<PhotoQuery , APIError>{
        return apiManager.request(endpoint: .photos, method: .Get, params: params.toDictionary())
    }
}
